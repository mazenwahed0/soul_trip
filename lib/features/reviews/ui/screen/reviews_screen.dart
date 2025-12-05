import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/models/review_model.dart';
import 'package:soul_trip/core/models/user_model/user_model.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/utils/snackbars/loaders.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_state.dart';
import '../../../../core/widgets/common/search/home_search_widget.dart';
import '../../logic/post_review/post_review_cubit.dart';
import '../../logic/post_review/post_review_state.dart';
import '../../logic/reviews_ui/reviews_ui_cubit.dart';
import '../../logic/reviews_ui/reviews_ui_state.dart';
import '../../logic/write_review/write_review_cubit.dart';
import '../../logic/write_review/write_review_state.dart';
import '../widgets/review_section.dart';
import '../widgets/reviews_tabs.dart';
import '../widgets/write_review_widget.dart';
import 'package:soul_trip/core/widgets/common/header/home_header_widget.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: BlocProvider ReviewsUiCubit locally (Only specific to this screen)
    return BlocProvider(
      create: (context) => ReviewsUiCubit(),
      child: const _ReviewsScreenBody(),
    );
  }
}

class _ReviewsScreenBody extends StatelessWidget {
  const _ReviewsScreenBody();

  @override
  Widget build(BuildContext context) {
    // 1. Listen to AuthCubit to get the LATEST user data (Live updates)
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final currentUser = authState.userModel ?? UserModel.empty();
        final currentUserId = currentUser.id;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              // 2. Listen to ReviewsUiCubit for UI State (Search/Tabs)
              child: BlocBuilder<ReviewsUiCubit, ReviewsUiState>(
                builder: (context, uiState) {
                  return Column(
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 15,
                          bottom: 0,
                        ),
                        child: HomeHeaderWidget(
                          icon: Soultrip.search,
                          iconColor: uiState.showSearch
                              ? ColorTheme().primaryBlue
                              : Colors.grey.shade400,
                          onTap: () {
                            context.read<ReviewsUiCubit>().toggleSearchBar();
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Write Review Section
                      BlocConsumer<WriteReviewCubit, WriteReviewState>(
                        listener: (context, state) {
                          if (state.status == ReviewStatus.success) {
                            FocusScope.of(context).unfocus();
                            Loaders.success(
                              context,
                              title: "Review Posted!",
                              message:
                                  "Your review has been posted successfully",
                            );
                          } else if (state.status == ReviewStatus.error) {
                            Loaders.error(
                              context,
                              title: "Error",
                              message:
                                  state.errorMessage ?? "An error occurred",
                            );
                          }
                        },
                        builder: (context, state) {
                          return WriteReviewWidget(
                            selectedImage: state.selectedImage,
                            onMediaTap: () => context
                                .read<WriteReviewCubit>()
                                .pickReviewImage(),
                            onRemoveImage: () =>
                                context.read<WriteReviewCubit>().removeImage(),
                            onPostTap: (caption) {
                              FocusScope.of(context).unfocus();
                              // Use data from AuthCubit
                              context.read<WriteReviewCubit>().addReview(
                                userId: currentUserId,
                                name: currentUser.fullName,
                                caption: caption,
                                profileImage: currentUser.profilePicture,
                              );
                            },
                          );
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Tabs
                      ReviewsTabsBoxes(
                        selectedIndex: uiState.selectedTab,
                        onTabChanged: (index) {
                          FocusScope.of(context).unfocus();
                          context.read<ReviewsUiCubit>().changeTab(index);
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Search bar
                      if (uiState.showSearch) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: HomeSearchBarWidget(
                            autofocus: true,
                            showFilter: false,
                            hintText: 'Search reviews...',
                            onChanged: (value) {
                              context.read<ReviewsUiCubit>().updateSearchQuery(
                                value,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],

                      // Reviews List
                      Expanded(
                        // 3. Listen to ReviewCubit for Data
                        child: BlocBuilder<ReviewCubit, ReviewState>(
                          builder: (context, reviewState) {
                            List<ReviewModel> filteredReviews =
                                List<ReviewModel>.from(reviewState.reviews);

                            // Tabs filter
                            if (uiState.selectedTab == 1) {
                              filteredReviews = filteredReviews
                                  .where((r) => r.userId == currentUserId)
                                  .toList();
                            } else if (uiState.selectedTab == 2) {
                              filteredReviews = filteredReviews
                                  .where(
                                    (r) => r.savedBy.contains(currentUserId),
                                  )
                                  .toList();
                            }

                            // Search filter
                            if (uiState.searchQuery.isNotEmpty) {
                              final query = uiState.searchQuery.toLowerCase();
                              filteredReviews = filteredReviews.where((r) {
                                final caption = r.caption.toLowerCase();
                                final name = r.name.toLowerCase();
                                return caption.contains(query) ||
                                    name.contains(query);
                              }).toList();
                            }

                            // Sort
                            filteredReviews.sort(
                              (a, b) => b.time.compareTo(a.time),
                            );

                            // EMPTY STATE
                            if (filteredReviews.isEmpty) {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.search_off,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          uiState.searchQuery.isNotEmpty
                                              ? 'No Reviews Found With "${uiState.searchQuery}"'
                                              : 'No Reviews Yet',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.h,
                              ),
                              itemCount: filteredReviews.length,
                              itemBuilder: (context, index) {
                                final review = filteredReviews[index];
                                return ReviewSection(
                                  review: review,
                                  currentUser: currentUser,
                                  onLike: () => context
                                      .read<ReviewCubit>()
                                      .toggleLike(review.docId, currentUserId),
                                  onSave: () {
                                    context.read<ReviewCubit>().toggleSave(
                                      review.docId,
                                      currentUserId,
                                    );
                                  },
                                  onComment: () => debugPrint('Comment'),
                                  onShare: () => debugPrint('Share'),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
