import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';

class FoxBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTapItem;

  const FoxBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _bottomBar,
      currentIndex: currentIndex,
      onTap: onTapItem,
      elevation: 0,
      // When set type to shifting => consider set background color for each BottomNavigationBarItem
      // When set type to fixed => consider set background color at backgroundColor || fixedColor at BottomNavigationBar
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      //fixedColor: Colors.orange.withOpacity(0.6),
      iconSize: 24,
      selectedItemColor: AppColors.navActiveItemColor,
      unselectedItemColor: AppColors.navUnActiveItemColor,
      selectedFontSize: 16,
      unselectedFontSize: 14,
      selectedLabelStyle: GoogleFonts.sourceCodePro(
        //fontSize: 20, // Override selectedFontSize attribute
        // color: Colors.white,
      ),
      unselectedLabelStyle: GoogleFonts.sourceCodePro(
        //fontSize: 20, // Override unselectedFontSize attribute
        //color: Colors.purpleAccent,
      ),
      selectedIconTheme: const IconThemeData(
        color: AppColors.navActiveItemColor, // Override selectedItemColor attribute
        opacity: 0.8,
        size: 24, // Override iconSize attribute
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppColors.navUnActiveItemColor, // Override unselectedItemColor attribute
        opacity: 0.8,
        size: 24, // Override iconSize attribute
      ),
      showUnselectedLabels: true,
      showSelectedLabels: true,
    );
  }

  /// Component Widgets
  List<BottomNavigationBarItem> get _bottomBar => [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      activeIcon: Icon(Icons.home_max_rounded),
      backgroundColor: Colors
          .white, // Will be override if backgroundColor form BottomNavigationBar has been set
      label: 'Home',
      tooltip: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.flutter_dash_rounded),
      activeIcon: Icon(Icons.flutter_dash_rounded),
      backgroundColor: Colors.white,
      label: 'Flutter School',
      tooltip: 'Flutter School',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.abc_rounded),
      activeIcon: Icon(Icons.back_hand_rounded),
      backgroundColor: Colors.white,
      label: 'Testing',
      tooltip: 'Testing',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      activeIcon: Icon(Icons.settings_backup_restore_rounded),
      backgroundColor: Colors.white,
      label: 'Setting',
      tooltip: 'Setting',
    ),
  ];
}