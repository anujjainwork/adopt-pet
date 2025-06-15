import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect_match/core/common/appbar.dart';
import 'package:pawfect_match/core/common/toggle_theme_button.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/core/theme/theme_getters.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomCenterAppBar(title: 'Settings'),
        body: Column(children: [
          SizedBox(height: 10.h,),
          themeToggleButton(context)
        ],
      ),
      ),
    );
  }
}

Widget themeToggleButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
    child: Container(
      height: 80.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: cardColor(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Toggle theme', style: AppTextStyles.button),
          ToggleThemeButton()
        ],
      ),
    ),
  );
}
