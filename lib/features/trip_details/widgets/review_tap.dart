import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/trip_details/widgets/review_item.dart';
import 'package:soul_trip/features/trip_details/widgets/rating_progress.dart';

class ReviewsTab extends StatelessWidget {
  final double _overallRating;
  const ReviewsTab({super.key, required double overallRating}) : _overallRating = overallRating;

  static const String _starIconPath = 'assets/icons/StarIcon.png';
  static const double _starSize = 28.0;

  Widget _buildFullStarAsset() {
    return Padding(
      padding: EdgeInsets.only(right: 4.w),
      child: Image.asset(
        _starIconPath,
        width: _starSize.sp,
        height: _starSize.sp,
        color: ColorTheme().primaryYellow, 
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.star, 
          color: ColorTheme().primaryYellow, 
          size: _starSize.sp,
        ), 
      ),
    );
  }

   Widget _buildStarRatingRow(double rating) {
    final int maxStars = 5;
    final int fullStars = rating.floor();
    final double fractionalPart = rating - fullStars;

    return Row(
      children: List.generate(maxStars, (index) {
        if (index < fullStars) {
          // Full Star
          return _buildFullStarAsset();
        } else if (index == fullStars && fractionalPart > 0) {
          // Fractional Star (Clipped)
          return Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: ClippedStar(
              size: _starSize.sp,
              assetPath: _starIconPath,
              fraction: fractionalPart,
              color: ColorTheme().primaryYellow,
            ),
          );
        } else {
          // Empty Star
          return Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: Icon(
              Icons.star_border, 
              color: Colors.grey.shade300, 
              size: _starSize.sp,
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy Data for the review list
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'Nora Ahmed',
        'time': '2 hours ago',
        'comment': 'This trip was amazing. It was very organized. The experts were very professional and my arthritis got so much better.',
        'profileImage': 'https://res.cloudinary.com/da5c5nstz/image/upload/v1764169497/b4bf854289c3d7050e8037d3c7575a0b30a3a1ac_pemgro.png',
        'reviewImage': 'https://res.cloudinary.com/da5c5nstz/image/upload/v1764168050/unsplash_bRit2WpoSSc_idtok1.png',
        'likes': 22,
        'comments': 22,
        'shares': 22,
      },
      {
        'name': 'Nora Ahmed',
        'time': '2 hours ago',
        'comment': 'This trip was amazing. It was very organized. The experts were very professional and my arthritis got so much better.',
        'profileImage': 'https://res.cloudinary.com/da5c5nstz/image/upload/v1764169497/b4bf854289c3d7050e8037d3c7575a0b30a3a1ac_pemgro.png',
        'reviewImage': 'https://res.cloudinary.com/da5c5nstz/image/upload/v1764168050/unsplash_bRit2WpoSSc_idtok1.png',
        'likes': 22,
        'comments': 22,
        'shares': 22,
      },
      
      
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stars and Score
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStarRatingRow(_overallRating), // Using the new function
                  Text(
                    _overallRating.toStringAsFixed(1),
                    style: AppTextStyles.medium20().copyWith(
                      color: ColorTheme().blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              
              // Progress Bars
              RatingProgressItem(label: 'Activities', rating: 4.5),
              RatingProgressItem(label: 'Experts', rating: 4.7),
              RatingProgressItem(label: 'Location', rating: 4.0),
            ],
          ),
        ),
    
        SizedBox(height: 24.h),
    
        // ----------------------------------------------------
        // 2. REVIEW LIST
        // ----------------------------------------------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: reviews.map((review) => ReviewItem(
                name: review['name'] as String,
                time: review['time'] as String,
                comment: review['comment'] as String,
                profileImage: review['profileImage'] as String,
                reviewImage: review['reviewImage'] as String,
                likes: review['likes'] as int,
                comments: review['comments'] as int,
                shares: review['shares'] as int,
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
// --- 6. Main Preview Function ---
@Preview()
Widget previewReviewsTab() {
  return MaterialApp(
    debugShowCheckedModeBanner: false, 
    home: ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white, // Light background for contrast
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const ReviewsTab(overallRating: 4.3), // Display the new ReviewsTab
      ),
    ),
  );
}

