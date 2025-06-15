import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/core/theme/theme_getters.dart';
import 'package:pawfect_match/features/home/presentation/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: GestureDetector(
        onTap: () => homeBloc.add(SearchBoxLoadMore()),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          height: 40.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: greyCardColor(context)
          ),
          child: Center(child: Text('Load more', style: AppTextStyles.button)),
        ),
      ),
    );
  }
}