import 'package:flutter/material.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      body: const Center(
        child: Text('Details of the trip will be shown here.'),
      ),
    );
  }
}