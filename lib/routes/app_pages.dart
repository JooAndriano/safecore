import 'package:get/get.dart';
import '../modules/home/views/home_view.dart';
import '../modules/medical/views/medical_list_view.dart';
import '../modules/disaster/views/disaster_list_view.dart';
import '../modules/disaster/views/disaster_detail_view.dart';
import '../modules/emergency/views/emergency_view.dart';
import '../modules/preparation/views/preparation_view.dart';
import '../modules/ai_assistant/views/ai_assistant_view.dart';
import '../modules/settings/views/settings_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/home';
  static const String medicalList = '/medical-list';
  static const String disasterList = '/disaster-list';
  static const String disasterDetail = '/disaster-detail';
  static const String emergency = '/emergency';
  static const String preparation = '/preparation';
  static const String aiAssistant = '/ai-assistant';
  static const String settings = '/settings';

  // Deep linking pattern untuk disaster detail dengan parameter ID
  static const String disasterDetailDynamic = '/disaster-detail/:id';

  // Deep linking pattern untuk medical detail dengan parameter ID
  static const String medicalDetailDynamic = '/medical-list/:id';

  /// Extract disaster ID dari route
  static String? getDisasterId(String route) {
    if (route.startsWith(disasterDetail)) {
      final parts = route.split('/');
      return parts.length > 3 ? parts[3] : null;
    }
    return null;
  }

  /// Build route dengan parameter
  static String buildDisasterDetailRoute(String id) {
    return '$disasterDetail/$id';
  }

  static String buildMedicalDetailRoute(String id) {
    return '$medicalList/$id';
  }
}

class AppPages {
  AppPages._();

  static const String initial = AppRoutes.home;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.medicalList,
      page: () => MedicalListView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.disasterList,
      page: () => DisasterListView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.disasterDetail,
      page: () => DisasterDetailView(),
      transition: Transition.fadeIn,
      // Deep linking support untuk disaster detail dengan ID parameter
      middlewares: [],
    ),
    GetPage(
      name: AppRoutes.emergency,
      page: () => EmergencyView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.preparation,
      page: () => PreparationView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.aiAssistant,
      page: () => AiAssistantView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsView(),
      transition: Transition.fadeIn,
    ),
  ];

  /// Daftar route utama yang ditampilkan di bottom navigation
  static const List<String> mainTabs = [
    AppRoutes.home,
    AppRoutes.preparation,
    AppRoutes.aiAssistant,
    AppRoutes.settings,
  ];

  /// Daftar route yang full screen (menyembunyikan bottom nav)
  static const Set<String> fullScreenRoutes = {
    AppRoutes.emergency,
    AppRoutes.medicalList,
    AppRoutes.disasterList,
    AppRoutes.disasterDetail,
  };
}