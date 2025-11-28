import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theme/colors.dart';
import 'widgets/splash_content.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  // Animation Controller
  late AnimationController _controller;

  // Animations
  late Animation<double> _slideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _logoRevealAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _setupAnimations();
    _controller.forward();

    // Navigation logic handles entirely by Animation completion + RouteGuard
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // GoRouter's Guard will redirect this to Login if not authenticated
        context.go(Routes.homeView);
      }
    });
  }

  void _setupAnimations() {
    // Phase 1: Text Fades In (0% -> 20%)
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );

    // Sequence: Start Slightly Low -> Slight Rise -> Drop to Center
    _slideAnimation = TweenSequence<double>([
      // 1. Start slightly below center (Offset 40 instead of 100)
      TweenSequenceItem(tween: ConstantTween<double>(40.0), weight: 20.0),
      // 2. Slight Rise (40 -> -20)
      // Moves up just a little bit to make room for the logo
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 40.0,
          end: -20.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30.0,
      ),
      // 3. Hold position
      TweenSequenceItem(tween: ConstantTween<double>(-20.0), weight: 10.0),
      // 4. Drop Down to Center ( -20 -> 0)
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -20.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 60.0,
      ),
    ]).animate(_controller);

    // Phase 2: Bottom Logo Fades In (20% -> 50%)
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    // Phase 3: Top Logo Reveals (50% -> 70%)
    // heightFactor 0.3 means we initially show only the bottom 30% (Cropped more)
    _logoRevealAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.7, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme().whiteColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SplashContent(
            slideAnimation: _slideAnimation,
            textOpacity: _textFadeAnimation,
            logoOpacity: _logoOpacityAnimation,
            logoReveal: _logoRevealAnimation,
          );
        },
      ),
    );
  }
}
