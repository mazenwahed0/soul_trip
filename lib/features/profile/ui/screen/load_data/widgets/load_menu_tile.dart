import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/text_style.dart';

class LoadMenuTile extends StatelessWidget {
  const LoadMenuTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isLoading = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEBEBEB)),
      ),
      child: ListTile(
        onTap: isLoading ? null : onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorTheme.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: colorTheme.primaryBlue, size: 24.sp),
        ),
        title: Text(
          title,
          style: AppTextStyles.semiBold16().copyWith(
            color: colorTheme.navyBlue,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.regular12().copyWith(
            color: colorTheme.grayMedium,
          ),
        ),
        trailing: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorTheme.primaryBlue,
                ),
              )
            : Icon(
                Icons.arrow_forward_ios_rounded,
                color: colorTheme.grayMedium,
                size: 18.sp,
              ),
      ),
    );
  }
}
