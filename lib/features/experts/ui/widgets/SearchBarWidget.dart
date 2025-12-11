import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:soul_trip/core/models/text_field_model/text_field_model.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/widgets/custom_text_form_field.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_state.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          color: colors.offWhite,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Icon(Soultrip.search, color: colors.grayMedium, size: 22.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: CustomTextFormField(
                textFieldModel: TextFieldModel(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  hintText: 'Search',
                  validator: null,
                  maxLines: 1,
                  ischangeColor: true,
                  icon: null,

                  onChanged: (value) {
                    context.read<ExpertCubit>().searchExperts(value);
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final expertCubit = context.read<ExpertCubit>();

                final result = await context.push<List<ExpertModel>>(
                  Routes.expertsfilterscreen,
                  extra: {
                    'allExperts': expertCubit.allExperts,
                    'expertCubit': expertCubit,
                  },
                );

                if (result != null && result is List<ExpertModel>) {
                  expertCubit.emit(ExpertLoaded(expert: result));
                }
              },
              child: Container(
                width: 56.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: colors.whiteColor,
                  border: const Border(
                    left: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Soultrip.filter,
                    color: colors.primaryBlue,
                    size: 22.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
