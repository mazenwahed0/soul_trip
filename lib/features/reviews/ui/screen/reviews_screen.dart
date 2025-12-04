import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/utils/snackbars/loaders.dart';
import 'package:soul_trip/features/profile/data/user/user_repository.dart';
import 'package:soul_trip/core/theme/colors.dart';
import '../../controller/post_review_cubit.dart';
import '../../controller/write_review_cubit.dart';
import '../../model/write_review_state.dart';
import '../../model/post_review_state.dart';
import '../widgets/review_section.dart';
import '../widgets/reviews_tabs.dart';
import '../widgets/write_review_widget.dart';
import '../../../../core/dependency_injection/set_up_dependencies.dart';
import 'package:soul_trip/core/widgets/common/header/home_header_widget.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  bool showSearch = false;
  String searchQuery = '';
  int selectedTab = 0;
  String currentUserId = '';
  String currentUserName = 'Guest';
  String currentUserProfileImage = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final userRepo = getIt<UserRepository>();
    final result = await userRepo.fetchUserDetails();

    if (!mounted) return;

    result.fold((l) => currentUserId = '', (user) {
      currentUserId = user.id;
      currentUserName = user.fullName;
      currentUserProfileImage = user.profilePicture;
    });

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
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
                  iconColor: showSearch
                      ? ColorTheme().primaryBlue
                      : Colors.grey.shade400,
                  backGroundColor: ColorTheme().backgroundLightGray,
                  onTap: () {
                    setState(() {
                      showSearch = !showSearch;
                      if (!showSearch) searchQuery = '';
                    });
                  },
                ),
              ),
              SizedBox(height: 20.h),

              // Write Review Section
              BlocListener<WriteReviewCubit, WriteReviewState>(
                listener: (context, state) {
                  if (state.status == ReviewStatus.success) {
                    FocusScope.of(context).unfocus();
                    Loaders.success(
                      context,
                      title: "Review Posted!",
                      message: "Your review has been posted successfully",
                    );
                  } else if (state.status == ReviewStatus.error) {
                    Loaders.error(
                      context,
                      title: "Error",
                      message: state.errorMessage ?? "An error occurred",
                    );
                  }
                },
                child: WriteReviewWidget(
                  onMediaTap: () => debugPrint('Media tapped'),
                  onPostTap: (caption) {
                    FocusScope.of(context).unfocus();
                    context.read<WriteReviewCubit>().addReview(
                      userId: currentUserId,
                      name: currentUserName,
                      caption: caption,
                      profileImage: currentUserProfileImage,
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Tabs
              ReviewsTabsBoxes(
                selectedIndex: selectedTab,
                onTabChanged: (index) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    selectedTab = index;
                  });
                },
              ),
              SizedBox(height: 20.h),
              // Search bar shown when search icon tapped
              if (showSearch) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.trim().toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],

              // Reviews List
              Expanded(
                child: BlocBuilder<ReviewCubit, ReviewState>(
                  builder: (context, state) {
                    List<Review> filteredReviews = List<Review>.from(
                      state.reviews,
                    );

                    // Tabs filter
                    if (selectedTab == 1) {
                      filteredReviews = filteredReviews
                          .where((r) => r.userId == currentUserId)
                          .toList();
                    } else if (selectedTab == 2) {
                      filteredReviews = filteredReviews
                          .where((r) => r.savedBy.contains(currentUserId))
                          .toList();
                    }

                    // Search filter
                    if (searchQuery.isNotEmpty) {
                      filteredReviews = filteredReviews.where((r) {
                        final caption = (r.caption).toLowerCase();
                        final name = (r.name).toLowerCase();
                        return caption.contains(searchQuery) ||
                            name.contains(searchQuery);
                      }).toList();
                    }

                    // Sort
                    filteredReviews.sort((a, b) => b.time.compareTo(a.time));

                    // ----------------------------------------------------
                    // EMPTY STATE — SAFE (No Overflow)
                    // ----------------------------------------------------
                    if (filteredReviews.isEmpty) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height *
                              0.2, // safe area
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  searchQuery.isNotEmpty
                                      ? 'No Reviews Found With "$searchQuery"'
                                      : 'No Reviews Yet',
                                  style: TextStyle(
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

                    // ----------------------------------------------------
                    // LIST VIEW
                    // ----------------------------------------------------
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                      ),
                      itemCount: filteredReviews.length,
                      itemBuilder: (context, index) {
                        final review = filteredReviews[index];
                        return ReviewSection(
                          review: review,
                          currentUserId: currentUserId,
                          onLike: () => context.read<ReviewCubit>().toggleLike(
                            review.docId,
                            currentUserId,
                          ),
                          onSave: () {
                            context.read<ReviewCubit>().toggleSave(
                              review.docId,
                              currentUserId,
                            );
                            Loaders.success(
                              context,
                              title: "Changed Successfully!",
                              message:
                                  "Your save status has been updated successfully",
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
          ),
        ),
      ),
    );
  }
}
