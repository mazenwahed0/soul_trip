import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/model/text_field_model/text_field_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/widgets/custom_text_form_field.dart';

import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ColorTheme().grayVeryLight,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorTheme().grayVeryLight,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Soultrip.search, color: ColorTheme().primaryBlue, size: 22.sp),
            widthSpace(8.w),
            Expanded(
              child: CustomTextFormField(
                textFieldModel: TextFieldModel(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  hintText: 'Search',
                  validator: null,
                  maxLines: 1,
                  ischangeColor: true,
                ),
              ),
            ),
            widthSpace(8.w),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorTheme().primaryBlue,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorTheme().blackColor,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Soultrip.filter,
                color: ColorTheme().whiteColor,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
