import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/trip_details/widgets/trip_header.dart';
import 'package:soul_trip/features/trip_details/widgets/trip_price_badge.dart';
import 'package:soul_trip/core/widgets/common/taps.dart';
import 'package:soul_trip/features/trip_details/widgets/about_tap.dart';
import 'package:soul_trip/features/trip_details/widgets/experts_tap.dart';
import 'package:soul_trip/features/trip_details/widgets/review_tap.dart';
import 'package:flutter/widget_previews.dart';



class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});
  

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen>{

  @override
  Widget build(BuildContext context) {
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

    ];
    
    return Scaffold(
      body:  Column(
          children: [
            const TripHeader(
              imageUrl: [
                "https://res.cloudinary.com/da5c5nstz/image/upload/v1764205879/unsplash_tnRb6IwpJAE_zij5xd.png",
              ],
            ),

            // --- Tab Bar Section (Taps widget) ---
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            //   child: Taps(controller: _tabController,
            //     tabs: const [
            //      AboutTap(),
            //      ExpertsTap(),
            //      ReviewsTab(overallRating: 4.8),
            //     ],
            //   ),
            // ),



          ],
        ),


    );
  }
}

@Preview()
Widget previewTripDetailsScreen() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => const TripDetailsScreen(),
    ),
  );
}