import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pawfect_match/core/common/confetti_dialog.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/core/theme/theme_getters.dart';
import 'package:pawfect_match/features/details/presentation/bloc/details_bloc.dart';
import 'package:pawfect_match/features/details/presentation/widgets/image_viewer.dart';
import 'package:pawfect_match/features/shared_models/pet_model.dart';

class DetailsScreen extends StatefulWidget {
  final PetModel petModel;
  const DetailsScreen({super.key, required this.petModel});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  void initState() {
    final detailsBloc = context.read<DetailsBloc>();
    detailsBloc.add(InitialDetailsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pet = widget.petModel;
    final detailsBloc = context.read<DetailsBloc>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(pet.name, style: AppTextStyles.heading)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              /// Image Viewer
              SizedBox(
                height: 320.h,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15.r),
                  color: textColor(context),
                  dashPattern: [12, 3],
                  strokeWidth: 0.8,
                  child: Container(
                    width: double.infinity,
                    color: bgColor(context),
                    child: Hero(
                      tag: 'petImage-${pet.id}',
                      child: CustomImageViewer(imageUrl: pet.imagePath)),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// Pet Description
              SizedBox(
                height: 90.h,
                  child: Text(pet.description, style: AppTextStyles.body),
                ),
              
              SizedBox(height: 20.h),

              /// Animal Stats Grid
              Expanded(flex: 10, child: animalStats(context, pet)),

              Spacer(),

              /// Adopt Me Button
              adoptMeButton(pet, detailsBloc),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget animalStats(BuildContext context, PetModel pet) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 2.7,
      physics: NeverScrollableScrollPhysics(),
      children: [
        statCard(
          context: context,
          icon: pet.gender.toLowerCase() == 'male' ? Icons.male : Icons.female,
          label: 'Gender: ${pet.gender}',
        ),
        statCard(context: context, icon: Icons.cake, label: 'Age: ${pet.age}'),
        statCard(
          context: context,
          icon: FontAwesomeIcons.dollarSign,
          label: 'Price: ${pet.cost}',
        ),
        statCard(
          context: context,
          icon: Icons.pets,
          label: 'Breed: ${pet.breed}',
        ),
      ],
    );
  }

  Widget statCard({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: cardColor(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: secondaryColor(context)),
          SizedBox(width: 10.w),
          Expanded(
            // Ensures text wraps/adjusts within available space
            child: AutoSizeText(
              label,
              style: AppTextStyles.button,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              minFontSize: 10, // Optional: controls how small text can shrink
              stepGranularity:
                  1, // Must be a divisor of minFontSize (10/1 = 10)
            ),
          ),
        ],
      ),
    );
  }

  Widget adoptMeButton(PetModel petModel, DetailsBloc detailsBloc) {
    return GestureDetector(
      onTap: () {
        detailsBloc.add(AdoptPet(petModel: petModel));
      },
      child: BlocConsumer<DetailsBloc, DetailsState>(
        listener: (context, state) {
        if (state is PetAdopted) {
          showDialog(
            context: context,
            builder: (_) => const ConfettiDialog(
              title: "Adoption Successful!",
              message: "You've given a new home to a loving pet 🐾",
            ),
          );
        }
      },
        builder: (context, state) {
          return Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  (petModel.isAdopted || state is PetAdopted)
                      ? greyCardColor(context)
                      : secondaryColor(context),
              borderRadius: BorderRadius.circular(15.r),
            ),
            alignment: Alignment.center,
            child: Text(
              (petModel.isAdopted || state is PetAdopted) ? "Already adopted" : "Adopt Me",
              style: TextStyle(
                color: (petModel.isAdopted || state is PetAdopted) ? Colors.white : Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
