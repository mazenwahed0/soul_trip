import 'package:flutter/material.dart';
import 'package:soul_trip/core/widgets/common/appbar/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications', showBackButton: true),
      body: const Center(child: Text('Notification Screen')),
    );
  }
}
