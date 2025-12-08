const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

// Scheduled function: Runs every 8 hours
exports.sendScheduledTripNotification = functions.pubsub
  .schedule("every 8 hours")
  .onRun(async (context) => {
    console.log("Starting scheduled trip notification job...");

    try {
      // 1. Get all users
      // Note: For large scale, use pagination or batches
      const usersSnapshot = await db.collection("Users").get();

      const promises = usersSnapshot.docs.map(async (userDoc) => {
        const userId = userDoc.id;
        const userData = userDoc.data();
        const fcmToken = userData.fcmToken;

        if (!fcmToken) {
          console.log(`No FCM token for user ${userId}`);
          return;
        }

        // 2. Get user's liked trips to find preferences
        const likesSnapshot = await db
          .collection("Users")
          .doc(userId)
          .collection("likes")
          .doc("trips")
          .collection("trips")
          .get();

        let preferredCategories = new Set();
        let likedTripIds = new Set();

        // Get liked trip details to extract categories
        // This assumes liked trips store category or we need to fetch them
        // If liked trips only store ID, we might need to fetch details.
        // Let's assume we can get category from the liked document or fetch it.
        // For optimization, let's assume we pick a random liked trip and use its category.

        if (!likesSnapshot.empty) {
          // Get a random liked trip to base recommendation on
          const randomLikeIndex = Math.floor(Math.random() * likesSnapshot.size);
          const likedDoc = likesSnapshot.docs[randomLikeIndex];
          const likedTripId = likedDoc.data().tripId;
          likedTripIds.add(likedTripId);

          // Fetch trip details to get category
          const tripDoc = await db.collection("HomeTrips").doc(likedTripId).get();
          if (tripDoc.exists) {
            preferredCategories.add(tripDoc.data().category);
          }
        }

        // 3. Find a trip to recommend
        let tripToRecommend = null;

        if (preferredCategories.size > 0) {
          // Try to find a trip in preferred category
          const category = Array.from(preferredCategories)[0];
          const tripsSnapshot = await db
            .collection("HomeTrips")
            .where("category", "==", category)
            .limit(10) // Fetch a few to randomize
            .get();

          // Filter out liked trips and already sent notifications
          // For simplicity, just filter liked ones locally
          const candidates = tripsSnapshot.docs.filter(
            (doc) => !likedTripIds.has(doc.id)
          );

          if (candidates.length > 0) {
            tripToRecommend =
              candidates[Math.floor(Math.random() * candidates.length)];
          }
        }

        // Fallback: Random trip if no preference match or no likes
        if (!tripToRecommend) {
          // Get a random ID (simplified approach)
          // Firestore doesn't support native random.
          // We'll fetch a few trips and pick one.
          const randomTripsSnapshot = await db
            .collection("HomeTrips")
            .limit(10)
            .get();
            
          if (!randomTripsSnapshot.empty) {
             const docs = randomTripsSnapshot.docs;
             tripToRecommend = docs[Math.floor(Math.random() * docs.length)];
          }
        }

        if (!tripToRecommend) {
          console.log(`No trips found to recommend for user ${userId}`);
          return;
        }

        const tripData = tripToRecommend.data();
        const tripId = tripToRecommend.id;

        // 4. Send Notification
        const message = {
          notification: {
            title: `Explore: ${tripData.title}`,
            body: `Check out this amazing trip in ${tripData.location}! ${tripData.price} EGP`,
          },
          data: {
            tripId: tripId,
            type: "trip_promotion",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
          },
          token: fcmToken,
        };

        await admin.messaging().send(message);
        console.log(`Notification sent to user ${userId} for trip ${tripId}`);

        // 5. Store notification in Firestore
        await db
          .collection("notifications")
          .doc(userId)
          .collection("notifications")
          .add({
            title: message.notification.title,
            description: message.notification.body,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
            isRead: false,
            tripId: tripId,
            type: "trip_promotion",
            imageUrl: tripData.image || "",
          });
      });

      await Promise.all(promises);
      console.log("Scheduled trip notification job completed.");
    } catch (error) {
      console.error("Error in scheduled trip notification job:", error);
    }
  });
