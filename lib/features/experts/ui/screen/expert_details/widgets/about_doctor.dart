import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/ui/screen/expert_details/widgets/stars_widget.dart';

class AboutDoctor extends StatelessWidget {
  final ExpertModel expert;

  const AboutDoctor({super.key, required this.expert});

  @override
  Widget build(BuildContext context) {
    // Top Container (Gradient Overlay)
    return Container(
      width: 375.w,
      // Reduced bottom padding to bring next section closer
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
        top: 20.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0.0), // Transparent top
            const Color(0xFFFFFFFF).withOpacity(0.63), // Glassy middle
            const Color(0xFFFFFFFF).withOpacity(0.9), // White bottom
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Name and Rating (Now on the same line)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  expert.name,
                  style: AppTextStyles.semiBold16(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Rating widget aligned to the right
              StarsWidget(rating: expert.rating.toString()),
            ],
          ),

          SizedBox(height: 4.h),

          // Row 2: Location/Specialization
          Text(
            expert.location,
            style: AppTextStyles.regular12().copyWith(
              color: const Color(0xFF898989),
            ),
          ),

          SizedBox(height: 16.h),

          // Stats Box (Experience, Fees, Reviews)
          Container(
            width: 343.w,
            height: 62.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEBEBEB), width: 2.w),
              borderRadius: BorderRadius.circular(16.r),

              color: const Color(0xFFEBEBEB).withOpacity(0.10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem("+${expert.experienceYears}y", "Experience"),

                _buildStatItem("+\$${expert.fees}", "Fees"),

                _buildStatItem("+${expert.reviewsCount}", "Reviews"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return SizedBox(
      width: 70.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.medium16().copyWith(
              color: const Color(0xFF262626),
            ),
          ),
          Text(
            label,
            style: AppTextStyles.regular12().copyWith(
              color: ColorTheme().grayDark,
            ),
          ),
        ],
      ),
    );
  }
}
