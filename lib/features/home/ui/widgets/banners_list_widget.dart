import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/error_state_widget.dart';
import 'package:soul_trip/features/home/manager/banner_cubit/banner_cubit.dart';
import 'package:soul_trip/features/home/manager/banner_cubit/banner_state.dart';
import 'package:soul_trip/features/home/ui/widgets/banner_widgets/banner_card_widget.dart';

class BannersListWidget extends StatefulWidget {
  const BannersListWidget({super.key});

  @override
  State<BannersListWidget> createState() => _BannersListWidgetState();
}

class _BannersListWidgetState extends State<BannersListWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        if (state is BannerLoading) {
          return _buildLoadingState(colors);
        }

        if (state is BannerError) {
          return ErrorStateWidget(
            message: state.message,
            onRetry: () {
              context.read<BannerCubit>().streamBanners();
            },
          );
        }

        if (state is BannerLoaded) {
          final banners = state.banners;

          if (banners.isEmpty) {
            return _buildEmptyState(colors);
          }

          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Carousel
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: banners.length,
                itemBuilder: (context, index, realIndex) {
                  return BannerCardWidget(
                    banner: banners[index],
                    onTap: () {
                      // TODO: Navigate to banner details
                    },
                    onBookNow: () {
                      // TODO: Handle book now action
                    },
                    onFavoriteToggle: () {
                      // TODO: Handle favorite toggle
                    },
                  );
                },
                options: CarouselOptions(
                  height: 220.h,
                  viewportFraction: 1.0, // Full width
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOutCubic,
                  pauseAutoPlayOnTouch: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),

              // Indicator Dots overlaid on banner
              Positioned(
                bottom: 12.h,
                child: _buildIndicatorDots(banners.length, colors),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildIndicatorDots(int count, ColorTheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => GestureDetector(
          onTap: () {
            _carouselController.animateToPage(index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _currentIndex == index ? 24.w : 8.w,
            height: 8.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: _currentIndex == index
                  ? colors.whiteColor
                  : colors.whiteColor.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ColorTheme colors) {
    return SizedBox(
      height: 200.h,
      child: Center(
        child: CircularProgressIndicator(color: colors.primaryBlue),
      ),
    );
  }

  Widget _buildEmptyState(ColorTheme colors) {
    return SizedBox(
      height: 200.h,
      child: Center(
        child: Text(
          'No retreats available',
          style: AppTextStyles.regular14().copyWith(color: colors.grayMedium),
        ),
      ),
    );
  }
}
