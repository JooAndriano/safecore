import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';

/// Medical Emergency List Screen
/// Menampilkan daftar darurat medis dengan gaya kartu
class MedicalListView extends StatelessWidget {
  MedicalListView({super.key});

  // MARK: Data

  /// Medical emergency items
  final List<MedicalEmergency> medicalEmergencies = [
    const MedicalEmergency(
      id: 'fainting',
      title: 'Pingsan',
      description: 'Hilangnya kesadaran sementara akibat kurangnya aliran darah ke otak.',
      icon: FontAwesomeIcons.heartCircleMinus,
      detailRoute: '/medical/fainting',
    ),
    const MedicalEmergency(
      id: 'bleeding',
      title: 'Pendarahan',
      description: 'Keluarnya darah dari pembuluh darah, bisa internal atau eksternal.',
      icon: FontAwesomeIcons.droplet,
      detailRoute: '/medical/bleeding',
    ),
    const MedicalEmergency(
      id: 'shortness_of_breath',
      title: 'Sesak Napas',
      description: 'Kesulitan bernapas atau merasa tidak cukup udara.',
      icon: FontAwesomeIcons.lungs,
      detailRoute: '/medical/shortness_of_breath',
    ),
    const MedicalEmergency(
      id: 'burns',
      title: 'Luka Bakar',
      description: 'Kerusakan kulit dan jaringan akibat panas, bahan kimia, atau listrik.',
      icon: FontAwesomeIcons.fire,
      detailRoute: '/medical/burns',
    ),
    const MedicalEmergency(
      id: 'seizures',
      title: 'Kejang',
      description: 'Aktivitas listrik otak yang tidak normal, menyebabkan perubahan perilaku atau gerakan.',
      icon: FontAwesomeIcons.brain,
      detailRoute: '/medical/seizures',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Darurat Medis',
          style: AppTypography.h3.copyWith(color: AppColors.lightText),
        ),
        backgroundColor: AppColors.emergencyRed,
        iconTheme: const IconThemeData(color: AppColors.lightText),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: medicalEmergencies.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = medicalEmergencies[index];
          return _buildMedicalEmergencyCard(context, item);
        },
      ),
    );
  }

  // MARK: Widgets

  /// Medical emergency card widget
  Widget _buildMedicalEmergencyCard(BuildContext context, MedicalEmergency item) {
    return AppCard(
      onTap: () => Get.toNamed(item.detailRoute),
      child: Row(
        children: [
          AppIcon(
            icon: item.icon, // Keep as is, AppIcon should handle dynamic type
            color: AppColors.emergencyRed,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.h4(item.title),
                const SizedBox(height: 4),
                AppText.body2(
                  item.description,
                  color: AppColors.secondaryText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          FaIcon(FontAwesomeIcons.chevronRight, size: 16, color: AppColors.secondaryText),
        ],
      ),
    );
  }
}

// MARK: Data Models

/// Medical emergency item model
class MedicalEmergency {
  final String id;
  final String title;
  final String description;
  final dynamic icon; // Changed to dynamic
  final String detailRoute;

  const MedicalEmergency({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.detailRoute,
  });
}
