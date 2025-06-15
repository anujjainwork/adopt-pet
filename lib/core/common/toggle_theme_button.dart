import 'package:flutter/material.dart';
import 'package:pawfect_match/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final systemIsDark = Theme.of(context).brightness == Brightness.dark;

    // Determine the effective active dark mode status
    final isDark = themeProvider.themeMode == ThemeMode.system
        ? systemIsDark
        : themeProvider.isDarkMode;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.light_mode, size: 20),
        Switch.adaptive(
          value: isDark,
          onChanged: (_) => themeProvider.toggleTheme(),
        ),
        const Icon(Icons.dark_mode, size: 20),
      ],
    );
  }
}
