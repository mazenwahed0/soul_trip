import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class widthSpace extends StatelessWidget {
   widthSpace(this.width,{super.key,});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width.w,);
  }
}
class heightSpace extends StatelessWidget {
   heightSpace(this.height,{super.key,});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h,);
  }
}