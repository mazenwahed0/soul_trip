import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widget_previews.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/trip_details/widgets/review_tap.dart';

class TripDetailsCard extends StatefulWidget {
  final String image;
  final String title;
  final double rating;
  final String location;
  final String date;
  final String travellers;
  final String duration;
  final String cancellation;
  final String cancellationNote;
  final String price;

  const TripDetailsCard({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.location,
    required this.date,
    required this.travellers,
    required this.duration,
    required this.cancellation,
    required this.cancellationNote,
    required this.price,
  });

  @override
  State<TripDetailsCard> createState() => _TripDetailsCardState();
}

class _TripDetailsCardState extends State<TripDetailsCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  widget.image,
                  height: 84,
                  width: 84,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.semiBold14().copyWith(
                        color: ColorTheme().blackColor,
                      ),
                    ),

                    Row(
                      children: [
                        buildStarRatingRow(4, 12),
                        Text("${widget.rating}"),
                      ],
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/location.png',
                          width: 8.w,
                          height: 10.w,
                          color: ColorTheme().navyBlue,
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.location,
                          style: AppTextStyles.regular12().copyWith(
                            color: ColorTheme().grayDark,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // TOGGLE BUTTON
              IconButton(
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 14),

          // =========================
          // EXPANDABLE CONTENT
          // =========================
          if (isExpanded) ...[
            _item(
              'assets/icons/solar_calendar-bold.png',
              widget.date,
              trailing: "Edit",
              height: 20.h,
              width: 18.w,
            ),
            _item('assets/icons/profile.png', widget.travellers),
            _item('assets/icons/time.png', widget.duration),
            _item(
              'assets/icons/done.png',
              widget.cancellation,
              subtitle: widget.cancellationNote,
              color: const Color(0xFF28AC47),
            ),

           const SizedBox(height: 10),
          ],

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.price,
                style: AppTextStyles.semiBold14().copyWith(
                  color: ColorTheme().blackColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _item(
    String icon,
    String text, {
    String? subtitle,
    String? trailing,
    Color? color,
    double? height,
    double? width,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: width ?? 16.w,
            height: height ?? 16.h,
            color: color ?? ColorTheme().primaryBlue,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: ColorTheme().grayDark,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),

          if (trailing != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                trailing!,
                style: AppTextStyles.semiBold14().copyWith(
                  color: ColorTheme().primaryBlue,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

@Preview(name: "TripDetailsCard Preview")
Widget previewTripDetailsCard() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: TripDetailsCard(
              image:
                  "https://res.cloudinary.com/da5c5nstz/image/upload/v1764530373/unsplash_pb8MhOgjlEk_ug7aqj.png",
              title: "Healing Journey in the Oasis",
              rating: 4.0,
              location: "Siwa, Egypt",
              date: "Saturday, 25 Nov",
              travellers: "2 travellers",
              duration: "5 days / 4 nights",
              cancellation: "Free Cancellation",
              cancellationNote: "Until 8:00 AM on Nov 24",
              price: "400 \$ / Night",
            ),
          ),
        ),
      ),
    ),
  );
}

