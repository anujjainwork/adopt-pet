import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/core/theme/theme_getters.dart';
import 'package:pawfect_match/features/home/presentation/bloc/home_bloc.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';
import 'package:provider/provider.dart';

class PetListItem extends StatelessWidget {
  final PetModel petModel;
  const PetListItem({super.key, required this.petModel});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      child: Container(
        height: 80.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: cardColor(context),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.transparent,
              child: Hero(
                tag: 'petImage-${petModel.id}',
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: petModel.imagePath,
                    fit: BoxFit.cover,
                    width: 50.r,
                    height: 50.r,
                    placeholder:
                        (context, url) => Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error, color: textColor(context),),
                  ),
                ),
              ),
            ),

            SizedBox(width: 15.w),

            /// Left-side info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          petModel.name,
                          style: AppTextStyles.subheading,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(petModel.type, style: AppTextStyles.body),
                      SizedBox(width: 4.w),
                      Text('|', style: AppTextStyles.body),
                      SizedBox(width: 4.w),
                      Text(petModel.age, style: AppTextStyles.body),
                    ],
                  ),
                ],
              ),
            ),
            if (petModel.isAdopted) _isAdoptedTag(context),
            SizedBox(width: 20.w),

            /// Right-side favorite button
            _favouriteButton(context, petModel, homeBloc),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _favouriteButton(
    BuildContext context,
    PetModel petModel,
    HomeBloc homeBloc,
  ) {
    return GestureDetector(
      onTap: () => homeBloc.add(ToggleFavouritePet(petModel: petModel)),
      child: Icon(
        Icons.favorite,
        color: petModel.isFavourite ? Colors.red : Colors.grey,
        size: 24.sp,
      ),
    );
  }

  Widget _isAdoptedTag(BuildContext context) {
    return Container(
      height: 25.h,
      width: 70.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: secondaryColor(context),
      ),
      child: Center(
        child: Text(
          'Adopted',
          style: TextStyle(color: Colors.black, fontSize: 12.sp),
        ),
      ),
    );
  }
}
