import 'shimmer.dart';
import 'package:flutter/material.dart';

class CListTileShimmer extends StatelessWidget {
  const CListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            /// Brand Logo
            CShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: 16.0),
            Column(
              children: [
                /// Brand Name
                CShimmerEffect(width: 100, height: 15),
                SizedBox(height: 8.0),

                /// Brand products
                CShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
