import 'package:flutter/material.dart';
import 'package:pawfect_match/features/bottomnavbar/bottomnavbar.dart';
import 'package:pawfect_match/features/favourites/view/favourites_view.dart';
import 'package:pawfect_match/features/history/view/history_view.dart';
import 'package:pawfect_match/features/home/presentation/view/home_view.dart';
import 'package:pawfect_match/utils/settings_view.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [Homeview(), HistoryView(),FavouritesView(),SettingsView()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
