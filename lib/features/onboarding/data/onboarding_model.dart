import '../../../core/utils/constant.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnboardingModel> list = [
    OnboardingModel(
      image: ConstantVariable.onboarding1,
      title: "Welcome to Soul Trip",
      description:
          "Discover wellness journeys that bring balance to your body, mind, and soul.",
    ),
    OnboardingModel(
      image: ConstantVariable.onboarding2,
      title: "Explore Wellness Travel",
      description:
          "From desert healing retreats to mindful escapes by the Nile — explore destinations designed for your well-being",
    ),
    OnboardingModel(
      image: ConstantVariable.onboarding3,
      title: "Begin your journey to peace",
      description:
          "Reconnect with yourself through mindful travel and natural healing.",
    ),
  ];
}
