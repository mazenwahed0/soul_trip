import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

// Custom clipper for the curved bottom shape - exact match with rounded corners
class CardBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 20.0;
    const bottomCurveRadius = 24.0;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - bottomCurveRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - bottomCurveRadius,
      size.height,
    );

    path.cubicTo(
      size.width * 0.95,
      size.height,
      size.width * 0.85,
      size.height,
      size.width * 0.78,
      size.height - 5,
    );

    path.cubicTo(
      size.width * 0.70,
      size.height - 10,
      size.width * 0.60,
      size.height - 11,
      size.width * 0.5,
      size.height - 11,
    );

    path.cubicTo(
      size.width * 0.40,
      size.height - 11,
      size.width * 0.30,
      size.height - 10,
      size.width * 0.22,
      size.height - 5,
    );

    path.cubicTo(
      size.width * 0.15,
      size.height,
      size.width * 0.05,
      size.height,
      bottomCurveRadius,
      size.height,
    );

    path.quadraticBezierTo(0, size.height, 0, size.height - bottomCurveRadius);

    path.lineTo(0, radius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CreditCardWidget extends StatefulWidget {
  final String cardNumber;
  final String cardHolderName;
  final String validThru;
  final String cardType;
  final String bankCode;

  const CreditCardWidget({
    Key? key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.validThru,
    this.cardType = 'VISA CARD',
    this.bankCode = '1234',
  }) : super(key: key);

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  static const String _basePath = 'assets/images/';
  static const String _cardLayer1 = '${_basePath}cardLayer1.png';
  static const String _cardLayer2 = '${_basePath}cardLayer2.png';
  static const String _cardChip = '${_basePath}cardChip.png';

  String _formatCardNumber(String text) {
    if (text.isEmpty) return "1235 2569 9548 9276";

    final clean = text.replaceAll(" ", "");
    final buffer = StringBuffer();

    for (int i = 0; i < clean.length; i++) {
      buffer.write(clean[i]);
      if ((i + 1) % 4 == 0 && i != clean.length - 1) {
        buffer.write(" ");
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 290;
    const double cardHeight = 180;

    return Column(
      children: [
        RepaintBoundary(
          child: Container(
            width: cardWidth.w,
            height: cardHeight.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipPath(
              clipper: CardBottomCurveClipper(),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      _cardLayer1,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) =>
                          const ColoredBox(color: Color(0xFF003366)),
                    ),
                  ),

                  Positioned(
                    child: Image.asset(
                      _cardLayer2,
                      fit: BoxFit.fitHeight,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// VISA CARD label
                        Text(
                          widget.cardType,
                          style: AppTextStyles.aldrich6().copyWith(
                            color: ColorTheme().whiteColor,
                            letterSpacing: 0,
                          ),
                        ),

                        SizedBox(height: 18.h),

                        /// CHIP
                        Image.asset(
                          _cardChip,
                          width: 50.w,
                          height: 28.h,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 50.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                        ),

                        SizedBox(height: 18.h),

                        /// CARD NUMBER
                        Text(
                          _formatCardNumber(widget.cardNumber),
                          style: AppTextStyles.aldrich10().copyWith(
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),

                        // SizedBox(height:2.h),

                        /// NAME AND EXPIRY
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Name column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.bankCode,
                                  style: AppTextStyles.aldrich8().copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  widget.cardHolderName,
                                  style: AppTextStyles.aldrich6().copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 7.sp,
                                  ),
                                ),
                              ],
                            ),

                            /// Expiry column
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 12.0,
                                top: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "VALID",
                                        style: AppTextStyles.aldrich6()
                                            .copyWith(
                                              color: Colors.white,

                                              letterSpacing: 0.5,
                                            ),
                                      ),
                                      Text(
                                        "THRU",
                                        style: AppTextStyles.aldrich6()
                                            .copyWith(
                                              color: Colors.white,

                                              letterSpacing: 0.5,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 2.w),
                                  Image.asset(
                                    'assets/icons/rightArrow.png',
                                    width: 4.w,
                                    height: 4.h,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const SizedBox.shrink(),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    widget.validThru,
                                    style: AppTextStyles.aldrich10().copyWith(
                                      color: Colors.white,

                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Image.asset(
          '${_basePath}shadow.png',
          width: 345.w,
          height: 50.h,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

@Preview(name: "CreditCardWidget Preview")
Widget previewCreditCardWidget() {
  return const MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: CreditCardWidget(
          cardNumber: '1234567812345678',
          cardHolderName: 'Noura Ahmed',
          validThru: '05/30',
        ),
      ),
    ),
  );
}
