import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/constant.dart';

class OnboardingModel {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {'image': imageUrl, 'title': title, 'description': description};
  }

  factory OnboardingModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OnboardingModel(
      imageUrl: data['image'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }

  static List<OnboardingModel> list = [
    OnboardingModel(
      imageUrl: ConstantVariable.onboarding1,
      title: "Welcome to Soul Trip",
      description:
          "Discover wellness journeys that bring balance to your body, mind, and soul.",
    ),
    OnboardingModel(
      imageUrl: ConstantVariable.onboarding2,
      title: "Explore Wellness Travel",
      description:
          "From desert healing retreats to mindful escapes by the Nile — explore destinations designed for your well-being",
    ),
    OnboardingModel(
      imageUrl: ConstantVariable.onboarding3,
      title: "Begin your journey to peace",
      description:
          "Reconnect with yourself through mindful travel and natural healing.",
    ),
  ];
}
