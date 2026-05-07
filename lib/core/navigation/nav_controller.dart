import 'package:get/get.dart';
import '../../routes/app_pages.dart';

/// Navigation Controller - Mengelola state bottom navigation bar
/// Sinkronisasi dengan AppPages untuk navigasi yang konsisten
class NavController extends GetxController {
  var currentIndex = 0.obs;

  static const int homeIndex = 0;
  static const int preparationIndex = 1;
  static const int aiAssistantIndex = 2;
  static const int settingsIndex = 3;

  /// Routes untuk tab bottom navigation
  /// Sinkron dengan AppPages.mainTabs
  static const List<String> mainTabs = [
    '/home',
    '/preparation',
    '/ai-assistant',
    '/settings',
  ];

  /// Daftar route yang menggunakan bottom nav (bukan full screen)
  /// Termasuk main tabs saja, bukan detail routes
  static const Set<String> bottomNavRoutes = {
    '/home',
    '/preparation',
    '/ai-assistant',
    '/settings',
  };

  /// Daftar route full screen yang menyembunyikan bottom nav
  /// Sinkron dengan AppPages.fullScreenRoutes
  static const Set<String> fullScreenRoutes = {
    '/emergency',
    '/medical-list',
    '/disaster-list',
    '/disaster-detail',
    '/medical-list/fainting',
    '/medical-list/bleeding',
    '/medical-list/shortness_of_breath',
    '/medical-list/burns',
    '/medical-list/seizures',
    '/disaster-detail/earthquake',
    '/disaster-detail/flood',
    '/disaster-detail/tsunami',
    '/disaster-detail/volcanic_eruption',
    '/disaster-detail/landslide',
    '/disaster-detail/fire',
  };

  /// Cek apakah route saat ini adalah full screen (harus hide bottom nav)
  static bool isFullScreenRoute(String route) {
    // Cek exact match
    if (fullScreenRoutes.contains(route)) return true;

    // Cek dynamic routes (dengan parameter ID)
    if (route.startsWith('/medical-list/') || route.startsWith('/disaster-detail/')) {
      return true;
    }

    return false;
  }

  /// Cek apakah route saat ini adalah bottom nav tab
  bool isMainTab(String route) {
    return mainTabs.contains(route);
  }

  /// Dapatkan index tab berdasarkan route
  int getTabIndex(String route) {
    final index = mainTabs.indexOf(route);
    return index >= 0 ? index : homeIndex;
  }

  void setTab(int index) {
    currentIndex.value = index;
    // Navigate ke tab yang dipilih menggunakan Get.offNamed
    // untuk memastikan stack bersih saat switch tab
    switch (index) {
      case homeIndex:
        Get.offNamed(AppRoutes.home);
        break;
      case preparationIndex:
        Get.offNamed(AppRoutes.preparation);
        break;
      case aiAssistantIndex:
        Get.offNamed(AppRoutes.aiAssistant);
        break;
      case settingsIndex:
        Get.offNamed(AppRoutes.settings);
        break;
    }
  }
}