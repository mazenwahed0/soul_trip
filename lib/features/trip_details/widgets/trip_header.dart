import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';


class TripHeader extends StatelessWidget {
  final List<String> imageUrl;
  final VoidCallback? onTapBack;

  const TripHeader({
    super.key,
    required this.imageUrl,
    this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    final VoidCallback backAction = onTapBack ?? () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    };
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Use the first image from the imageUrl list
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            child: Image.network(
              imageUrl.isNotEmpty ? imageUrl[0] : '',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 12+ topPadding,
            left: 13,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: backAction,
              ),
            ),
          ),
          Positioned(
            top: 12+topPadding,
            right: 13,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () {},
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < imageUrl.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == 0 ? 10 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == 0 ? Colors.white : Colors.white70,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
        );
  }
}


const String _kPlaceholderImageUrl = 'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=800&q=80';

@Preview(name: 'Trip Header Preview')
Widget tripHeaderPreview() {
  return MaterialApp(
    home: Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          TripHeader(
            imageUrl: const [_kPlaceholderImageUrl],
            onTapBack: _handleNoOp,
          ),
        ],
      ),
    ),
  );
}

// Simple function that does nothing
void _handleNoOp() {}