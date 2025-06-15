import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/core/theme/theme_getters.dart';
import 'package:pawfect_match/features/home/presentation/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchBoxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchBoxController.addListener(() {
      setState(() {}); // Rebuild when text changes to show/hide X button
    });
  }

  @override
  void dispose() {
    _searchBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: greyCardColor(context),
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: _searchBoxController,
          onChanged: (value) {
            homeBloc.add(SearchBoxQueryChanged(query: value));
          },
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: AppTextStyles.button,
            prefixIcon: Icon(Icons.search, color: generalIconColor(context)),
            suffixIcon: _searchBoxController.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _searchBoxController.clear();
                      homeBloc.add(PetListRequest());
                    },
                    child: Icon(Icons.close, color: generalIconColor(context)),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          ),
        ),
      ),
    );
  }
}

