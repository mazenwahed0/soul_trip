import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:soul_trip/features/trip_details/widgets/custom_icon_text.dart';
class AboutTap extends StatelessWidget {
  const AboutTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconText(
            icon: 'assets/icons/wave.png',
            text: 'Soak in Siwa’s sulfur springs and mineral pools to relieve inflammation.',
          ),
          const SizedBox(height: 16),
          CustomIconText(icon: 'assets/icons/Group.png', text: 'Experience black sand therapy sessions that soothe muscles and joints.'),
          const SizedBox(height: 16),
          CustomIconText(icon: 'assets/icons/Vector.png', text: 'Practice mobility-focused yoga and light stretching guided by a physiotherapist.'),
          
          
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