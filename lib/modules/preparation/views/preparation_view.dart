import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';

/// Preparation Screen - Halaman persiapan perlengkapan dan tips bertahan
class PreparationView extends StatelessWidget {
  PreparationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreparationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Persiapan',
          style: AppTypography.h3.copyWith(color: AppColors.lightText),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.lightText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Perlengkapan Darurat
            AppText.h3('Perlengkapan Darurat'),
            const SizedBox(height: 8),
            AppText.body2(
              'Pastikan item berikut siap di dalam tas darurat Anda.',
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: 16),
            Obx(() => Column(
              children: controller.checklistItems.map((item) {
                return _buildChecklistItem(context, item, controller);
              }).toList(),
            )),

            const SizedBox(height: 32),

            // Section: Tips Bertahan
            AppText.h3('Tips Bertahan'),
            const SizedBox(height: 8),
            AppText.body2(
              'Panduan penting untuk meningkatkan kesiapsiagaan.',
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: 16),
            _buildTipCard(
              context,
              title: 'Perencanaan Bencana',
              icon: FontAwesomeIcons.mapLocationDot,
              description: 'Cara membuat rencana evakuasi dan titik kumpul keluarga.',
            ),
            const SizedBox(height: 12),
            _buildTipCard(
              context,
              title: 'Strategi Komunikasi',
              icon: FontAwesomeIcons.towerBroadcast,
              description: 'Cara tetap terhubung saat jaringan seluler terganggu.',
            ),
            const SizedBox(height: 12),
            _buildTipCard(
              context,
              title: 'Rencana Evakuasi',
              icon: FontAwesomeIcons.personRunning,
              description: 'Langkah aman meninggalkan area berbahaya dengan cepat.',
            ),
          ],
        ),
      ),
    );
  }

  // MARK: Widgets

  Widget _buildChecklistItem(BuildContext context, ChecklistItem item, PreparationController controller) {
    final isChecked = controller.checkedItems[item.id] ?? false;

    return AppCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: () => controller.toggleItem(item.id),
      child: Row(
        children: [
          FaIcon(
            isChecked ? FontAwesomeIcons.solidSquareCheck : FontAwesomeIcons.square,
            color: isChecked ? AppColors.successGreen : AppColors.secondaryText,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppText.body1(
              item.title,
              color: isChecked 
                  ? AppColors.secondaryText 
                  : Theme.of(context).brightness == Brightness.dark 
                      ? AppColors.lightText 
                      : AppColors.inverseText,
              emphasized: isChecked,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, {
    required String title,
    required dynamic icon,
    required String description,
  }) {
    return AppCard(
      onTap: () {
        Get.snackbar(
          title,
          'Detail tips akan segera hadir.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.darkSurface,
          colorText: AppColors.lightText,
        );
      },
      child: Row(
        children: [
          AppIcon(icon: icon, color: AppColors.infoBlue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.h4(title),
                const SizedBox(height: 4),
                AppText.body2(description, color: AppColors.secondaryText),
              ],
            ),
          ),
          FaIcon(FontAwesomeIcons.chevronRight, size: 14, color: AppColors.secondaryText),
        ],
      ),
    );
  }
}

// MARK: Controller

class PreparationController extends GetxController {
  // In a real app, this would use GetStorage or SharedPreferences
  final RxMap<String, bool> checkedItems = <String, bool>{}.obs;

  final List<ChecklistItem> checklistItems = [
    const ChecklistItem(id: 'air_minum', title: 'Air minum (untuk 3 hari)'),
    const ChecklistItem(id: 'makanan', title: 'Makanan cadangan tahan lama'),
    const ChecklistItem(id: 'p3k', title: 'Kotak P3K lengkap'),
    const ChecklistItem(id: 'senter', title: 'Senter & baterai cadangan'),
    const ChecklistItem(id: 'powerbank', title: 'Power bank & kabel charger'),
  ];

  void toggleItem(String id) {
    checkedItems[id] = !(checkedItems[id] ?? false);
  }
}

// MARK: Model

class ChecklistItem {
  final String id;
  final String title;

  const ChecklistItem({required this.id, required this.title});
}
