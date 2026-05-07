import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/themes/app_theme.dart';
import 'core/ai_local/controllers/ai_controller.dart';
import 'core/data/repositories/data_repository.dart';
import 'core/navigation/safe_core_shell.dart';
import 'routes/app_pages.dart';
import 'modules/disaster/views/disaster_detail_view.dart';
import 'modules/medical/views/medical_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive data layer
  await DataRepository.instance.initialize();
  
  // Pre-register AI Controller (lazy initialization, no model load yet)
  Get.put<AiController>(AiController());
  
  runApp(const SafeCoreApp());
}

class SafeCoreApp extends StatelessWidget {
  const SafeCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SAFECORE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      navigatorKey: Get.key,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      // OnGenerateRoute untuk menangani navigasi dari bottom nav
      onGenerateRoute: (settings) {
        final name = settings.name;

        // Handle deep linking untuk medical detail dengan ID
        // Medical detail menggunakan pattern /medical-list/:id
        if (name != null && name.startsWith('${AppRoutes.medicalList}/')) {
          return GetPageRoute(
            page: () => MedicalListView(),
            transition: Transition.fadeIn,
            settings: settings,
          );
        }

        // Handle deep linking untuk disaster detail dengan ID
        if (name != null && name.startsWith('${AppRoutes.disasterDetail}/')) {
          return GetPageRoute(
            page: () => DisasterDetailView(),
            transition: Transition.fadeIn,
            settings: settings,
          );
        }

        // Default route lookup menggunakan AppPages
        final page = AppPages.pages.firstWhere(
          (p) => p.name == name || name!.startsWith('${p.name}/'),
          orElse: () => AppPages.pages.first,
        );

        return GetPageRoute(
          page: page.page,
          transition: page.transition ?? Transition.fadeIn,
          settings: settings,
        );
      },
    );
  }
}
