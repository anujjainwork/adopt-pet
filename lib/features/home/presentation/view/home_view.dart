import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect_match/core/common/appbar.dart';
import 'package:pawfect_match/features/details/presentation/view/details_screen.dart';
import 'package:pawfect_match/features/home/presentation/bloc/home_bloc.dart';
import 'package:pawfect_match/features/home/presentation/widget/load_more_button.dart';
import 'package:pawfect_match/features/home/presentation/widget/pet_list_item.dart';
import 'package:pawfect_match/features/home/presentation/widget/search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() {
    context.read<HomeBloc>().add(PetListRefreshRequest());
  }

  void _onLoading() {
    context.read<HomeBloc>().add(PetListNextPageRequest());
  }
  @override
  void initState() {
    context.read<HomeBloc>().add(PetListRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomCenterAppBar(title: 'Home'),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is PetListLoaded || state is SearchFilterFromDB) {
              _refreshController.refreshCompleted();
              _refreshController.loadComplete();
            }
            if (state is PetListLoadingError) {
              _refreshController.refreshFailed();
              _refreshController.loadFailed();
            }
            return Column(
              children: [
                SizedBox(height: 15.h),
                SearchBox(),
                SizedBox(height: 15.h),
                Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: ClassicHeader(),
                    footer: ClassicFooter(),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child:
                        state is PetListLoaded && state.petlists.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    state.petlists.length +
                                    1, // +1 for LoadMoreButton
                                itemBuilder: (context, index) {
                                  if (index < state.petlists.length) {
                                    final pet = state.petlists[index];
                  
                                    return GestureDetector(
                                      onTap:
                                          () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) => DetailsScreen(
                                                    petModel: pet,
                                                  ),
                                            ),
                                          ),
                                      child: PetListItem(petModel: pet),
                                    );
                                  } else {
                                    // Last item => LoadMoreButton
                                    if (state is SearchFilterFromDB) {
                                      return Center(child: LoadMoreButton());
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }
                                },
                            )
                            : state is HomeInitial
                            ? const Center(child: CircularProgressIndicator())
                            : null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
