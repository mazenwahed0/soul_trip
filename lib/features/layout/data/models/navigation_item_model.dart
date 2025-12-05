import 'package:flutter/material.dart';

/// Model representing a bottom navigation item
class NavigationItemModel {
  const NavigationItemModel({
    this.icon,
    this.svgPath,
    required this.label,
    required this.route,
  }) : assert(
         icon != null || svgPath != null,
         'Must provide either icon or svgPath',
       );

  final IconData? icon;
  final String? svgPath;
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
