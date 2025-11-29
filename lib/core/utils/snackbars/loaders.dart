import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icon_pack/solar_bold_icons.dart';

import '../../theme/colors.dart';
import '../../theme/text_style.dart';

class Loaders {
  /// Hide current snackbar
  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Custom Success SnackBar
  static void success(
    BuildContext context, {
    required String title,
    String message = '',
    int duration = 3,
  }) {
    _showSnackBar(
      context: context,
      title: title,
      message: message,
      duration: duration,
      backgroundColor: const Color(0xFF0F766E),
      icon: SolarBoldIcons.checkCircle,
    );
  }

  /// Custom Error SnackBar
  static void error(
    BuildContext context, {
    required String title,
    String message = '',
    int duration = 3,
  }) {
    _showSnackBar(
      context: context,
      title: title,
      message: message,
      duration: duration,
      backgroundColor: ColorTheme().errorColor,
      icon: SolarBoldIcons.dangerCircle,
    );
  }

  /// Custom Warning SnackBar
  static void warning(
    BuildContext context, {
    required String title,
    String message = '',
    int duration = 3,
  }) {
    _showSnackBar(
      context: context,
      title: title,
      message: message,
      duration: duration,
      backgroundColor: const Color(0xFFF59E0B),
      icon: SolarBoldIcons.infoCircle,
    );
  }

  /// Internal method to build and show the SnackBar
  static void _showSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required int duration,
    required Color backgroundColor,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: duration),
          content: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                // Animated Icon
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: _PulsingIcon(icon: icon),
                ),
                SizedBox(width: 16.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.semiBold16().copyWith(
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      if (message.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          message,
                          style: AppTextStyles.regular12().copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

// Pulsing Icon Animation
class _PulsingIcon extends StatefulWidget {
  final IconData icon;

  const _PulsingIcon({required this.icon});

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Icon(
        widget.icon,
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }
}
