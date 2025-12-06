import 'package:flutter_bloc/flutter_bloc.dart';
import 'reviews_ui_state.dart';

class ReviewsUiCubit extends Cubit<ReviewsUiState> {
  ReviewsUiCubit() : super(const ReviewsUiState());

  void toggleSearchBar() {
    emit(
      state.copyWith(
        showSearch: !state.showSearch,
        // Clear query if closing search
        searchQuery: !state.showSearch ? '' : state.searchQuery,
      ),
    );
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query.trim()));
  }

  void changeTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }
}
