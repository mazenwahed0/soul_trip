import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/trip_details/widgets/trip_header.dart';
import 'package:soul_trip/features/trip_details/widgets/trip_price_badge.dart';
import 'package:soul_trip/core/widgets/common/taps.dart';
import 'package:soul_trip/features/trip_details/widgets/about_tap.dart';
import 'package:soul_trip/features/trip_details/widgets/experts_tap.dart';
import 'package:soul_trip/features/trip_details/widgets/review_tap.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      TripHeader(
                        imageUrl: [
                          "https://res.cloudinary.com/da5c5nstz/image/upload/v1764205879/unsplash_tnRb6IwpJAE_zij5xd.png",
                        ],
                        onTapBack: () => context.go(Routes.homeView),
                        title: "Healing Journey in the Oasis",
                        location: "Oasis, Egypt",
                        date: "25 Nov",
                      ),

                      /// PRICE BADGE
                      Positioned(
                        bottom: -32.h,
                        right: 16.w,
                        child: CardContent(price: "\$ 700", rating: 4),
                      ),
                    ],
                  ),
                  SizedBox(height: 48.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "A natural recovery experience designed to ease joint pain and restore mobility through Egypt’s healing springs, mineral sands, and expert-guided therapy.",
                      style: AppTextStyles.regular14().copyWith(
                        color: ColorTheme().grayMedium,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                Taps(
                  controller: _tabController,
                  tabHeaders: const [
                    Tab(text: "About"),
                    Tab(text: "Experts"),
                    Tab(text: "Reviews"),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            SingleChildScrollView(child: AboutTap()),
            SingleChildScrollView(child: ExpertsTap()),
            SingleChildScrollView(child: ReviewsTab(overallRating: 4.8)),
          ],
        ),
      ),

      /// BOTTOM BUTTON
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + bottomPadding,
          top: 8,
        ),
        child: PrimaryShadowButton(
          text: "Book Now",
          onPressed: () {
            print("Booking Trip: Healing Journey in the Oasis");
          },
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(_) => false;
}
