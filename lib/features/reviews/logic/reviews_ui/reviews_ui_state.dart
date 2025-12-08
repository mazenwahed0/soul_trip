import 'package:equatable/equatable.dart';

class ReviewsUiState extends Equatable {
  final bool showSearch;
  final String searchQuery;
  final int selectedTab;

  const ReviewsUiState({
    this.showSearch = false,
    this.searchQuery = '',
    this.selectedTab = 0,
  });

  ReviewsUiState copyWith({
    bool? showSearch,
    String? searchQuery,
    int? selectedTab,
  }) {
    return ReviewsUiState(
      showSearch: showSearch ?? this.showSearch,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [showSearch, searchQuery, selectedTab];
}
