import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect_match/core/common/appbar.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/features/details/presentation/view/details_screen.dart';
import 'package:pawfect_match/features/favourites/cubit/favourite_cubit.dart';
import 'package:pawfect_match/features/home/presentation/widget/pet_list_item.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {

  @override
  void initState() {
    final favouriteCubit = context.read<FavouriteCubit>();
    favouriteCubit.loadAllFavouritePets();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: CustomCenterAppBar(title: 'Favourites'),
            body: Column(
              children: [
                SizedBox(height: 15.h),
                if (state is FavouritePetsLoaded && state.favouritePets.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.favouritePets.length,
                      itemBuilder: (context, index) {
                        if (index < state.favouritePets.length) {
                          final pet = state.favouritePets[index];
            
                          return GestureDetector(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailsScreen(petModel: pet),
                                  ),
                                ),
                            child: PetListItem(petModel: pet),
                          );
                        }
                      },
                    ),
                  )
                else if (state is FavouriteInitial)
                  const Center(child: CircularProgressIndicator())
                else if (state is EmptyFavouritePetsLoaded)
                  Center(child: Text('No favourite pets yet...', style: AppTextStyles.subheading,),)
              ],
            ),
          ),
        );
      },
    );
  }
}
