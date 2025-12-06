import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import '../../../../core/theme/soultrip_icons.dart';

class WriteReviewWidget extends StatefulWidget {
  final VoidCallback onMediaTap;
  final VoidCallback? onRemoveImage;
  final void Function(String caption) onPostTap;
  final File? selectedImage;

  const WriteReviewWidget({
    super.key,
    required this.onMediaTap,
    this.onRemoveImage,
    required this.onPostTap,
    this.selectedImage,
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

            SizedBox(height: 8.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Media Button
                    GestureDetector(
                      onTap: widget.onMediaTap,
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.primaryBlue,
                            width: 1.5.w,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Soultrip.photoPlusSolid,
                            size: 18.sp,
                            color: colors.primaryBlue,
                          ),
                        ),
                      ),
                    ),

                    // Selected Image Preview (Beside the icon)
                    if (widget.selectedImage != null) ...[
                      SizedBox(width: 12.w),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              widget.selectedImage!,
                              height: 40.h,
                              width: 40.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Remove Button (Small X)
                          Positioned(
                            top: -6,
                            right: -6,
                            child: GestureDetector(
                              onTap: widget.onRemoveImage,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),

                // Post Button
                SizedBox(
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
                    icon: Icon(
                      Soultrip.edit,
                      size: 18.sp,
                      color: _isTextEmpty ? Colors.white : colors.whiteColor,
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
                      // CRITICAL: Override global theme's infinite width
                      minimumSize: const Size(0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
