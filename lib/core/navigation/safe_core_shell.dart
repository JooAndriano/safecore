import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../modules/ai_assistant/views/ai_assistant_view.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/preparation/views/preparation_view.dart';
import '../../modules/settings/views/settings_view.dart';
import 'nav_controller.dart';
import '../../routes/app_pages.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/typography.dart';

/// SafeCoreShell - Main shell dengan Bottom Navigation Bar
class SafeCoreShell extends StatelessWidget {
  const SafeCoreShell({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavController());

    return GetBuilder<NavController>(
      builder: (controller) {
        return Scaffold(
          body: _buildBody(controller.currentIndex.value),
          bottomNavigationBar: _buildBottomNav(controller),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case NavController.homeIndex:
        return HomeView();
      case NavController.preparationIndex:
        return PreparationView();
      case NavController.aiAssistantIndex:
        return const AiAssistantView();
      case NavController.settingsIndex:
        return SettingsView();
      default:
        return HomeView();
    }
  }

  Widget _buildBottomNav(NavController controller) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.setTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.emergencyRed,
        unselectedItemColor: AppColors.secondaryText,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.suitcaseMedical),
            activeIcon: FaIcon(FontAwesomeIcons.suitcaseMedical),
            label: 'Persiapan',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.psychology_outlined),
            activeIcon: Icon(Icons.psychology),
            label: 'Asisten AI',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}