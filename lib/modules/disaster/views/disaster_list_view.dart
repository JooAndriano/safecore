import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';

/// Natural Disaster List Screen
/// Menampilkan daftar bencana alam dengan gaya kartu
class DisasterListView extends StatelessWidget {
  const DisasterListView({super.key});

  // MARK: Data

  /// Natural disaster items
  final List<NaturalDisaster> naturalDisasters = const [
    NaturalDisaster(
      id: 'earthquake',
      title: 'Gempa',
      icon: FontAwesomeIcons.houseChimneyCrack,
      riskLevel: RiskLevel.high,
      detailRoute: '/disaster/earthquake',
    ),
    NaturalDisaster(
      id: 'flood',
      title: 'Banjir',
      icon: FontAwesomeIcons.water,
      riskLevel: RiskLevel.standard,
      detailRoute: '/disaster/flood',
    ),
    NaturalDisaster(
      id: 'tsunami',
      title: 'Tsunami',
      icon: FontAwesomeIcons.waterLadder,
      riskLevel: RiskLevel.high,
      detailRoute: '/disaster/tsunami',
    ),
    NaturalDisaster(
      id: 'volcanic_eruption',
      title: 'Gunung Meletus',
      icon: FontAwesomeIcons.mountainSun,
      riskLevel: RiskLevel.high,
      detailRoute: '/disaster/volcanic_eruption',
    ),
    NaturalDisaster(
      id: 'landslide',
      title: 'Tanah Longsor',
      icon: FontAwesomeIcons.hillAvalanche,
      riskLevel: RiskLevel.standard,
      detailRoute: '/disaster/landslide',
    ),
    NaturalDisaster(
      id: 'fire',
      title: 'Kebakaran',
      icon: FontAwesomeIcons.fire,
      riskLevel: RiskLevel.standard,
      detailRoute: '/disaster/fire',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bencana Alam',
          style: AppTypography.h3.copyWith(color: AppColors.lightText),
        ),
        backgroundColor: AppColors.emergencyOrange,
        iconTheme: const IconThemeData(color: AppColors.lightText),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: naturalDisasters.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = naturalDisasters[index];
          return _buildNaturalDisasterCard(context, item);
        },
      ),
    );
  }

  // MARK: Widgets

  /// Natural disaster card widget
  Widget _buildNaturalDisasterCard(BuildContext context, NaturalDisaster item) {
    return AppCard(
      onTap: () => Get.toNamed(item.detailRoute),
      child: Row(
        children: [
          AppIcon(
            icon: item.icon,
            color: _getRiskColor(item.riskLevel),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.h4(item.title),
                const SizedBox(height: 4),
                _buildRiskLabel(context, item.riskLevel),
              ],
            ),
          ),
          FaIcon(FontAwesomeIcons.chevronRight, size: 16, color: AppColors.secondaryText),
        ],
      ),
    );
  }

  /// Build risk level label
  Widget _buildRiskLabel(BuildContext context, RiskLevel riskLevel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getRiskColor(riskLevel).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText.body3(
        riskLevel == RiskLevel.high ? 'Tinggi' : 'Umum',
        color: _getRiskColor(riskLevel),
        emphasized: true,
      ),
    );
  }

  /// Get color based on risk level
  Color _getRiskColor(RiskLevel riskLevel) {
    switch (riskLevel) {
      case RiskLevel.high:
        return AppColors.emergencyRed;
      case RiskLevel.standard:
        return AppColors.warningYellow;
      default:
        return AppColors.secondaryText;
    }
  }
}

// MARK: Data Models

/// Natural disaster item model
class NaturalDisaster {
  final String id;
  final String title;
  final dynamic icon;
  final RiskLevel riskLevel;
  final String detailRoute;

  const NaturalDisaster({
    required this.id,
    required this.title,
    required this.icon,
    required this.riskLevel,
    required this.detailRoute,
  });
}

/// Risk level enum
enum RiskLevel {
  high,
  standard,
}
