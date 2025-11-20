import 'package:equatable/equatable.dart';

/// States for the layout navigation
abstract class LayoutState extends Equatable {
  const LayoutState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class LayoutInitial extends LayoutState {
  const LayoutInitial();
}

/// State when a navigation item is selected
class LayoutNavigationChanged extends LayoutState {
  const LayoutNavigationChanged({
    required this.currentIndex,
    required this.currentRoute,
  });

  final int currentIndex;
  final String currentRoute;

  @override
  List<Object?> get props => [currentIndex, currentRoute];
}
