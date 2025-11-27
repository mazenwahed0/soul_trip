import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:soul_trip/features/trip_details/widgets/custom_icon_text.dart';
class AboutTap extends StatelessWidget {
  const AboutTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconText(
            icon: Icons.info,
            text: 'About the Trip',
          ),
          const SizedBox(height: 12),
          CustomIconText(icon: Icons.airplanemode_active, text: 'Flight Details')
        ],
      ),
    );
  }
}

@Preview(name: "AboutTap Preview")
Widget previewAboutTap() {
  return const MaterialApp(
    home: Scaffold(
      body: AboutTap(),
    ),
  );
}