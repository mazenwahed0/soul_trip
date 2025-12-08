import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icon_pack/solar_bold_icons.dart';

import '../../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/snackbars/loaders.dart';
import '../../../../../core/widgets/common/appbar/custom_app_bar.dart';
import '../../../logic/data_upload/data_upload_cubit.dart';
import '../../../logic/data_upload/data_upload_state.dart';
import 'widgets/load_menu_tile.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DataUploadCubit>(),
      child: const _LoadDataBody(),
    );
  }
}

class _LoadDataBody extends StatelessWidget {
  const _LoadDataBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DataUploadCubit>();

    return Scaffold(
      backgroundColor: ColorTheme().whiteColor,
      appBar: const CustomAppBar(title: 'Upload Data'),
      body: BlocConsumer<DataUploadCubit, DataUploadState>(
        listener: (context, state) {
          if (state is DataUploadSuccess) {
            Loaders.success(context, title: "Success", message: state.message);
          } else if (state is DataUploadFailure) {
            Loaders.error(context, title: "Error", message: state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is DataUploadLoading;

          return Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                LoadMenuTile(
                  icon: SolarBoldIcons.uploadSquare,
                  title: 'Upload Onboarding',
                  subtitle:
                      'Uploads static onboarding to Firestore & Cloudinary',
                  isLoading: isLoading,
                  onTap: () {
                    cubit.uploadOnboardingData();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
