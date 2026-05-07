import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';

/// Settings Screen - Halaman konfigurasi aplikasi
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: AppTypography.h3.copyWith(color: AppColors.lightText),
        ),
        backgroundColor: AppColors.darkSurface,
        iconTheme: const IconThemeData(color: AppColors.lightText),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Section: Tampilan
          _buildSectionHeader('Tampilan'),
          Obx(() => _buildToggleItem(
                title: 'Mode Gelap',
                icon: FontAwesomeIcons.moon,
                value: controller.isDarkMode.value,
                onChanged: (val) => controller.toggleDarkMode(),
              )),
          const Divider(height: 1, indent: 64),
          Obx(() => _buildToggleItem(
                title: 'Notifikasi Darurat',
                icon: FontAwesomeIcons.bell,
                value: controller.isNotificationsEnabled.value,
                onChanged: (val) => controller.toggleNotifications(),
              )),

          const SizedBox(height: 24),

          // Section: Preferensi
          _buildSectionHeader('Preferensi'),
          _buildClickableItem(
            title: 'Bahasa',
            subtitle: 'Indonesia',
            icon: FontAwesomeIcons.language,
            onTap: () => _showLanguageDialog(context),
          ),

          const SizedBox(height: 24),

          // Section: Aplikasi
          _buildSectionHeader('Aplikasi'),
          _buildClickableItem(
            title: 'Tentang SAFECORE',
            subtitle: 'Versi 1.0.0',
            icon: FontAwesomeIcons.circleInfo,
            onTap: () => _showAboutDialog(context),
          ),
          const Divider(height: 1, indent: 64),
          _buildClickableItem(
            title: 'Kebijakan Privasi',
            icon: FontAwesomeIcons.shieldHalved,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // MARK: Widgets

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required dynamic icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: AppIcon(icon: icon, color: AppColors.secondaryText, size: 20),
      title: AppText.body1(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildClickableItem({
    required String title,
    String? subtitle,
    required dynamic icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: AppIcon(icon: icon, color: AppColors.secondaryText, size: 20),
      title: AppText.body1(title),
      subtitle: subtitle != null ? AppText.body3(subtitle, color: AppColors.secondaryText) : null,
      trailing: FaIcon(FontAwesomeIcons.chevronRight, size: 14, color: AppColors.secondaryText),
      onTap: onTap,
    );
  }

  // MARK: Dialogs

  void _showLanguageDialog(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.h3('Pilih Bahasa'),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Indonesia'),
              trailing: FaIcon(FontAwesomeIcons.circleCheck, color: AppColors.primary),
              onTap: () => Get.back(),
            ),
            ListTile(
              title: const Text('English'),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'SAFECORE',
      applicationVersion: '1.0.0',
      applicationIcon: null,
      children: [
        const Text('SAFECORE adalah asisten darurat pribadi yang dirancang untuk memberikan panduan keselamatan cepat dalam situasi kritis.'),
        const SizedBox(height: 8),
        FaIcon(FontAwesomeIcons.shieldHeart, color: AppColors.emergencyRed, size: 40),
      ],
    );
  }
}

// MARK: Controller

class SettingsController extends GetxController {
  final isDarkMode = true.obs;
  final isNotificationsEnabled = false.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications() {
    isNotificationsEnabled.value = !isNotificationsEnabled.value;
  }
}
