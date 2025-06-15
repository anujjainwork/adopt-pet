import 'package:flutter/material.dart';
import 'package:pawfect_match/core/theme/app_text_styles.dart';
import 'package:pawfect_match/core/theme/theme_getters.dart';
class CustomCenterAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomCenterAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: Text(
            title,
            style: AppTextStyles.heading
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: bgColor(context),
          foregroundColor: textColor(context),
        ),
         Divider(
          height: 0.1,
          thickness: 0.1,
          color: Colors.grey[400],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
