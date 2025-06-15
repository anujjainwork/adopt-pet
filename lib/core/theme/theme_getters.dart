import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Small global getters for use anywhere with context

Color primaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.primary;

Color secondaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.secondary;

Color bgColor(BuildContext context) =>
    Theme.of(context).colorScheme.background;

Color cardColor(BuildContext context) =>
    Theme.of(context).cardColor;

Color textColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkText
        : AppColors.lightText;

Color subtitleColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkSubtitle
        : AppColors.lightSubtitle;

Color generalIconColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkText
        : AppColors.lightText;

Color disabledColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkDisabled
        : AppColors.lightDisabled;
  
Color greyCardColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkGreyCard
        : AppColors.lightGreyCard;
