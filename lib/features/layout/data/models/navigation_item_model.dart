import 'package:flutter/material.dart';

/// Model representing a bottom navigation item
class NavigationItemModel {
  const NavigationItemModel({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationItemModel &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          label == other.label &&
          route == other.route;

  @override
  int get hashCode => icon.hashCode ^ label.hashCode ^ route.hashCode;
}
