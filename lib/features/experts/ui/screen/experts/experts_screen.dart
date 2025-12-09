import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/common/appbar/custom_app_bar.dart';
import 'package:soul_trip/core/widgets/common/search/home_search_widget.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/data/repo/experts_repository.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_state.dart';

import 'widgets/cards/expert_list_card.dart';

class ExpertsScreen extends StatelessWidget {
  const ExpertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpertCubit(
        repo: ExpertsRepository(firestore: FirebaseFirestore.instance),
      )..listenToexpert(),
      child: const _ExpertsScreenBody(),
    );
  }
}

class _ExpertsScreenBody extends StatelessWidget {
  const _ExpertsScreenBody();

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Scaffold(
      backgroundColor: colors.backgroundWhite,
      appBar: CustomAppBar(title: "Experts", showBackButton: false),
      body: Column(
        children: [
          SizedBox(height: 16.h),

          // Search Bar (Reusing Core Widget)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Builder(
              builder: (context) {
                return HomeSearchBarWidget(
                  searchBackgroundColor: const Color(0xFFFAFAFA),
                  filterIconColor: const Color(0xFF151515),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x66000000), // #00000040 (40% opacity)
                      blurRadius: 3,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  hintText: "Search",
                  onChanged: (value) {
                    context.read<ExpertCubit>().searchExperts(value);
                  },
                  onFilterTap: () async {
                    final expertCubit = context.read<ExpertCubit>();

                    final result = await context.push<List<ExpertModel>>(
                      Routes.expertsfilterscreen,
                      extra: {
                        'allExperts': expertCubit.allExperts,
                        'expertCubit': expertCubit,
                      },
                    );

                    if (result != null) {
                      expertCubit.updateExpertsList(result);
                    }
                  },
                );
              },
            ),
          ),

          SizedBox(height: 16.h),

          // List
          Expanded(
            child: BlocBuilder<ExpertCubit, ExpertState>(
              builder: (context, state) {
                if (state is ExpertLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: colors.primaryBlue),
                  );
                }

                if (state is ExpertLoaded) {
                  final experts = state.expert;

                  if (experts.isEmpty) {
                    return Center(
                      child: Text(
                        "No experts found",
                        style: AppTextStyles.regular14(),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: experts.length,
                    padding: EdgeInsets.only(bottom: 100.h),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final expert = experts[index];
                      return Center(
                        child: ExpertListCard(
                          imageUrl: expert.image,
                          name: expert.name,
                          location: expert.location,
                          specialization: expert.specialization,
                          rating: expert.rating,
                          price: expert.price,
                          onBookTap: () =>
                              _navigateToDetails(context, expert.id),
                          onCardTap: () =>
                              _navigateToDetails(context, expert.id),
                        ),
                      );
                    },
                  );
                }

                if (state is ExpertError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String expertId) {
    context.push('${Routes.expertsDetailsView}?id=$expertId');
  }
}
