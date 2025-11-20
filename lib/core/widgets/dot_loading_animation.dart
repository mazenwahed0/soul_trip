import 'package:flutter/material.dart';

class DotsLoadingAnimation extends StatefulWidget {
  const DotsLoadingAnimation({super.key});

  @override
  State<DotsLoadingAnimation> createState() => _DotsLoadingAnimationState();
}

class _DotsLoadingAnimationState extends State<DotsLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(); // يعيد الحركة بشكل لا نهائي

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Opacity(
                opacity: (_animation.value - (index * 0.33)).clamp(0.0, 1.0),
                child: const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
