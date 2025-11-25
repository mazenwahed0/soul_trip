import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:soul_trip/core/model/text_field_model/text_field_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/widgets/custom_text_form_field.dart';


class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: searchController,
              keyboardType: TextInputType.text,
              hintText: 'Search',
              validator: null,
              maxLines: 1,
              ischangeColor: true,
              icon: Soultrip.search,
            ),
          ),
          Positioned(
            right: 6,
            child: GestureDetector(
              onTap: () {
                // GoRouter.of(context).push("location");
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorTheme().primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Soultrip.filter,
                  color: ColorTheme().whiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



