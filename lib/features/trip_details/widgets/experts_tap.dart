import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class ExpertsTap extends StatelessWidget {
  const ExpertsTap({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
         children: [
            ExpertItem(
              name: 'Alice Smith',
              profession: 'Physiotherapist',
              imageUrl:
                  'https://res.cloudinary.com/da5c5nstz/image/upload/v1764380641/docSarah_gkhgpp.png',
              rating: 4.9,
            ),
            SizedBox(height: 10.h),
            ExpertItem(
              name: 'Bob Johnson',
              profession: 'Travel Consultant',
              imageUrl:
                  'https://res.cloudinary.com/da5c5nstz/image/upload/v1764380641/docSarah_gkhgpp.png',
              rating: 4.7,
            ),
            SizedBox(height: 10.h),
            ExpertItem(
              name: 'Catherine Lee',
              profession: 'Cultural Expert',
              imageUrl:
                  'https://res.cloudinary.com/da4b3zgxp/image/upload/v1763951882/doctor_fi54hn.png',
              rating: 4.8,
            ),
          ],
        ),
      ),
    );
  }
}



class ExpertItem extends StatelessWidget {
  final String name;
  final String profession;
  final String imageUrl;
  final double rating;

  const ExpertItem({
    super.key,
    required this.name,
    required this.profession,
    required this.imageUrl,
    required this.rating,
  });

  @override
Widget build(BuildContext context) {
  final String displayName = name.startsWith('Dr.') ? name : 'Dr. $name';
  
  // The outer Container remains the same, but its child will be a Stack.
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(
        color: Colors.grey.shade200,
        width: 1.w,
      )
    ),
    
    child: Stack( 
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imageUrl,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 16.w),

            Flexible( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// NAME 
                  Text(
                    displayName,
                    style: AppTextStyles.semiBold14()
                  ),

                  SizedBox(height: 4.h),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: ColorTheme().grayMedium,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      profession,
                      style: AppTextStyles.medium12().copyWith(
                        color: ColorTheme().whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        Positioned(
          right: 0,
          top: 0,  
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h), 
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Star Icon
                Image.asset( 
                  'assets/icons/StarIcon.png',
                  width: 16.w,
                  height: 16.h,
                ),
                SizedBox(width: 4.w),
                // Rating Text
                Text(
                  rating.toString(),
                  style: AppTextStyles.medium10()
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
}


@Preview(name: "ExpertsTap Preview")
Widget previewExpertsTap() {
    return ScreenUtilInit(
      child: const MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: ExpertsTap(),
          ),
        ),
      ),
    );

}
