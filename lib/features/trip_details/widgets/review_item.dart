import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widget_previews.dart';


class ReviewItem extends StatelessWidget {
  final String name;
  final String time;
  final String comment;
  final String profileImage;
  final String reviewImage;
  final int likes;
  final int comments;
  final int shares;

  const ReviewItem({
    super.key,
    required this.name,
    required this.time,
    required this.comment,
    required this.profileImage,
    required this.reviewImage,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });

  Widget _actionItem(String icon, int count) {
    return Row(
      children: [
        Image.asset(
          icon, 
          width: 12.w,
          height: 12.w,
        ),
        SizedBox(width: 4.w),
        Text(
          count.toString(),
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  profileImage,
                  width: 45.w,
                  height: 45.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Name + Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Heart Icon
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(0.1), // Added light red background
                ),
                child: Icon(Icons.favorite, color: Colors.red.shade600, size: 15.sp),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // COMMENT TEXT
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            child: Text(
              comment,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.4,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // REVIEW IMAGE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                reviewImage,
                height: 172.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                    height: 172.h,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: Text('Image Failed to Load', style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // ACTION BUTTONS
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              
              children: [
                // Switched to using Material Icons
                _actionItem('assets/icons/like.png', likes), 
                SizedBox(width: 18.w),
                _actionItem('assets/icons/comment.png', comments),
                SizedBox(width: 18.w),
                _actionItem('assets/icons/share.png', shares),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@Preview()
Widget previewReviewItem() {
  return MaterialApp(
    debugShowCheckedModeBanner: false, 
    home: Center( 
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        ReviewItem(
                          name: 'Nora Ahmed',
                          time: '2 hours ago',
                          comment:
                              'This trip was amazing. It was very organized. The experts were very professional and my arthritis got so much better.',
                          profileImage:
                              'https://res.cloudinary.com/da5c5nstz/image/upload/v1764169497/b4bf854289c3d7050e8037d3c7575a0b30a3a1ac_pemgro.png',
                          reviewImage:
                              'https://res.cloudinary.com/da5c5nstz/image/upload/v1764168050/unsplash_bRit2WpoSSc_idtok1.png',
                          likes: 22,
                          comments: 22,
                          shares: 22,
                        ),
                    ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
}


