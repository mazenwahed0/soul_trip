import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../models/wishlist_item_model.dart';

class WishlistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1 - Fetch the IDs of trips the user has liked
  Future<List<String>> getUserWishlistTripIds(String userId) async {
    final snapshot = await _firestore
        .collection('Users')
        .doc(userId)
        .collection('likes')
        .doc('trips')
        .collection('trips')
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  // 2 - Fetch data for each trip (modified to avoid crashes)
  Future<HomeTripModel?> getTripById(String tripId) async {
    final doc = await _firestore.collection('HomeTrips').doc(tripId).get();

    // Ensure the document exists and has data before converting
    if (!doc.exists || doc.data() == null) {
      return null; // If the trip is deleted, return null instead of crashing the app
    }

    return HomeTripModel.fromMap(doc.data()!, doc.id);
  }

  // 3 - Add trip to wishlist
  Future<void> addTripToWishlist(String userId, String tripId) async {
    await _firestore
        .collection('Users')
        .doc(userId)
        .collection('likes')
        .doc('trips')
        .collection('trips')
        .doc(tripId)
        .set({"likedAt": FieldValue.serverTimestamp(), "likedId": tripId});
  }

  // 4 - Remove trip from wishlist
  Future<void> removeTripFromWishlist(String userId, String tripId) async {
    await _firestore
        .collection('Users')
        .doc(userId)
        .collection('likes')
        .doc('trips')
        .collection('trips')
        .doc(tripId)
        .delete();
  }
}
