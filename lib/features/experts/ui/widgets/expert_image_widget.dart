import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/internet_check/cubit/internet_check__cubit.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class ExpertImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const ExpertImage({super.key, required this.imageUrl, this.height = 520});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityDisconnected) {
          return Container(
            width: double.infinity,
            height: height,
            color: Colors.grey[300],
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    size: 80,
                    color: ColorTheme().grayMedium,
                  ),
                  heightSpace(10),
                  Text(
                    "No Internet Connection",
                    style: TextStyle(color: ColorTheme().grayMedium),
                  ),
                  heightSpace(10),
                  PrimaryShadowButton(
                    onPressed: () =>
                        context.read<ConnectivityCubit>().checkConnectivity(),
                    text: "Retry",
                    height: 50.h,
                    width: 50.w,
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: height,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ColorTheme().grayLight,
                child:  Icon(Icons.error, size: 50, color: ColorTheme().grayLight),
              );
            },
          ),
        );
      },
    );
  }
}
