import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( 'Welcome to the Home Screen',),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.tripDetailsScreen);
              },
              child: const Text('Go to Trip Details'),
            ),
          ],
        ),
      ),
    );
  }
}
