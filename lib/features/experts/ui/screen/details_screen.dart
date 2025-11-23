import 'package:flutter/material.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/ExpertDetails.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomScrollView(slivers: [Expertdetails()]));
  }
}
