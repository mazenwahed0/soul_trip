import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class TripHeader extends StatelessWidget {
  final List<String> imageUrl;
  final VoidCallback? onTapBack;
  final String title;
  final String location;
  final String date;

  const TripHeader({
    super.key,
    required this.imageUrl,
    this.onTapBack,
    required this.title,
    required this.location,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    final VoidCallback backAction =
        onTapBack ??
        () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        };
    return SizedBox(
      height: 415.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: Stack(
              children: [
                Image.network(
                  imageUrl.isNotEmpty ? imageUrl[0] : '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 150, // adjust shadow height
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12 + topPadding,
            left: 13,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: backAction,
              ),
            ),
          ),
          Positioned(
            top: 12 + topPadding,
            right: 13,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () {},
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < imageUrl.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == 0 ? 10 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == 0 ? Colors.white : Colors.white70,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bold20().copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/location.png',
                      width: 14.w,
                      height: 14.h,
                      color: ColorTheme().whiteColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      location,
                      style: AppTextStyles.medium14().copyWith(
                        color: ColorTheme().whiteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/solar_calendar-bold.png',
                      width: 22.w,
                      height: 22.h,
                      color: ColorTheme().whiteColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: AppTextStyles.medium14().copyWith(
                        color: ColorTheme().whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// const String _kPlaceholderImageUrl =
//     'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=800&q=80';

// @Preview(name: 'Trip Header Preview')
// Widget tripHeaderPreview() {
//   return MaterialApp(
//     home: ScreenUtilInit(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         body: Column(
//           children: [
//             TripHeader(
//               imageUrl: const [_kPlaceholderImageUrl],
//               onTapBack: _handleNoOp,
//               title: "Healing Journey in the Oasis",
//               location: "Oasis, Egypt",
//               date: "25 Nov",
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// // Simple function that does nothing
// void _handleNoOp() {}
