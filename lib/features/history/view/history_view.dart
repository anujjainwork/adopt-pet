import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect_match/core/common/appbar.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/features/details/presentation/view/details_screen.dart';
import 'package:pawfect_match/features/history/cubit/history_cubit.dart';
import 'package:pawfect_match/features/home/presentation/widget/pet_list_item.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {

  @override
  void initState() {
    final historyCubit = context.read<HistoryCubit>();
    historyCubit.loadAllAdoptedPets();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: CustomCenterAppBar(title: 'History'),
            body: Column(
                  children: [
                    SizedBox(height: 15.h),
                    if (state is AdoptedListsLoaded && state.petlists.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              state.petlists.length,
                          itemBuilder: (context, index) {
                            if (index < state.petlists.length) {
                              final pet = state.petlists[index];
            
                              return GestureDetector(
                                onTap:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => DetailsScreen(petModel: pet),
                                      ),
                                    ),
                                child: PetListItem(petModel: pet),
                              );
                            }
                          },
                        ),
                      )
                    else if (state is HistoryInitial)
                      const Center(child: CircularProgressIndicator())
                    else if(state is EmptyAdoptedListLoaded)
                      Center(child: Text('No adopted pets yet...', style: AppTextStyles.subheading),)
                  ],
                ),
          ),
        );
      },
    );
  }
}
