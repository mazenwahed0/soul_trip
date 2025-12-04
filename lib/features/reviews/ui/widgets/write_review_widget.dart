import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WriteReviewWidget extends StatefulWidget {
  final VoidCallback onMediaTap;
  final void Function(String caption) onPostTap;

  const WriteReviewWidget({
    super.key,
    required this.onMediaTap,
    required this.onPostTap,
  });

  @override
  State<WriteReviewWidget> createState() => _WriteReviewWidgetState();
}

class _WriteReviewWidgetState extends State<WriteReviewWidget> {
  final TextEditingController _captionController = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    _captionController.addListener(_updatePostButtonState);
  }

  void _updatePostButtonState() {
    final isTextEmpty = _captionController.text.trim().isEmpty;
    if (_isTextEmpty != isTextEmpty) {
      setState(() {
        _isTextEmpty = isTextEmpty;
      });
    }
  }

  @override
  void dispose() {
    _captionController.removeListener(_updatePostButtonState);
    // This line is very important to prevent memory leaks
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();
    final borderColor = Colors.grey.shade200;
    final borderRadius = BorderRadius.circular(30.r);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _captionController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Write Your Review...',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),

            SizedBox(height: 12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Media Button
                SizedBox(
                  width: 45.w,
                  height: 40.h,
                  child: GestureDetector(
                    onTap: widget.onMediaTap,
                    child: Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.primaryBlue,
                          width: 1.5.w,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/imagePick.svg",
                          width: 18.sp,
                          height: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),

                // Post Button
                SizedBox(
                  width: 100.w,
                  height: 40.h,
                  child: ElevatedButton.icon(
                    onPressed: _isTextEmpty
                        ? null
                        : () {
                            final caption = _captionController.text.trim();
                            if (caption.isNotEmpty) {
                              widget.onPostTap(caption);
                              _captionController.clear();
                              // Close the keyboard after posting
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                    icon: SvgPicture.asset(
                      "assets/icons/pen.svg",
                      width: 18.sp,
                      height: 18.sp,
                      colorFilter: ColorFilter.mode(
                        _isTextEmpty ? Colors.white : colors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text(
                      'Post',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: _isTextEmpty
                          ? Colors.grey.shade400
                          : colors.whiteColor,
                      backgroundColor: _isTextEmpty
                          ? colors.grayVeryLight
                          : colors.primaryBlue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
