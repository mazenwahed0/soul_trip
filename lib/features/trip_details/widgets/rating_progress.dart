import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/trip_details/widgets/review_item.dart';

class RatingProgressItem extends StatelessWidget {
  final String label;
  final double rating;

  const RatingProgressItem({super.key, required this.label, required this.rating});

  @override
  Widget build(BuildContext context) {
    final double progressValue = rating / 5.0; 

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          // Label
          SizedBox(
            width: 60.w,
            child: Text(
              label,
              style: AppTextStyles.medium12().copyWith(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Progress Bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: SizedBox(
                height: 6.h,
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.grey.shade200,
                  color: ColorTheme().primaryYellow,
                  minHeight: 6.h,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Numeric Rating
          SizedBox(
            width: 30.w,
            child: Text(
              rating.toStringAsFixed(1),
              textAlign: TextAlign.end,
              style: AppTextStyles.medium12().copyWith( color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

@Preview()
Widget ratingProgressItemPreview() {
  return Container(
    padding: EdgeInsets.all(16.w),
    color: Colors.white,
    child: Column(
      children: [
        RatingProgressItem(
          label: 'Excellent',
          rating: 4.5,
        ),
        RatingProgressItem(
          label: 'Very Good',
          rating: 3.8,
        ),
        RatingProgressItem(
          label: 'Average',
          rating: 2.9,
        ),
        RatingProgressItem(
          label: 'Poor',
          rating: 1.5,
        ),
        RatingProgressItem(
          label: 'Terrible',
          rating: 0.8,
        ),
      ],
    ),
  );
}   


//Star Clipping

class StarClipper extends CustomClipper<Rect> {
  final double fraction;

  StarClipper(this.fraction);

  @override
  Rect getClip(Size size) {
    // Clips the rectangle from the left (0, 0) up to (width * fraction)
    return Rect.fromLTRB(0, 0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(StarClipper oldClipper) => oldClipper.fraction != fraction;
}

// --- 4. Clipped Star Widget (NEW) ---
class ClippedStar extends StatelessWidget {
  final double size;
  final String assetPath;
  final double fraction;
  final Color color;

  const ClippedStar({
    required this.size,
    required this.assetPath,
    required this.fraction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          ClipRect(
            clipper: StarClipper(fraction),
            child: Image.asset(
              assetPath,
              width: size,
              height: size,
              color: color,
              // Fallback for image asset loading failure
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.star,
                color: color,
                size: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

