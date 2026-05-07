import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';
import '../../../core/ai_local/ai_local.dart';
import '../../emergency/views/emergency_view.dart';

/// Disaster Detail Screen - Menampilkan detail bencana dengan tab SEBELUM, SAAT, SETELAH
class DisasterDetailView extends StatelessWidget {
  const DisasterDetailView({super.key});

  // MARK: Data

  final Map<String, DisasterDetail> disasterData = const {
    'earthquake': DisasterDetail(
      id: 'earthquake',
      title: 'Gempa Bumi',
      illustrationAsset: 'assets/images/disaster/earthquake.png',
      before: BeforeData(
        title: 'Sebelum Gempa',
        steps: [
          'Siapkan tas darurat berisi makanan, air, obat-obatan, dan dokumen penting.',
          'Amankan perabotan besar seperti lemari dan rak buku agar tidak mudah roboh.',
          'Buat rencana evakuasi keluarga dan tentukan titik kumpul yang aman.',
          'Pelajari cara mematikan listrik dan gas di rumah untuk mencegah bahaya tambahan.',
          'Latih drill gempa bersama keluarga secara berkala (drop, cover, hold on).',
        ],
      ),
      during: DuringData(
        title: 'Saat Gempa',
        buttonText: 'Mulai Panduan Darurat Gempa',
        emergencyId: 'earthquake',
      ),
      after: AfterData(
        title: 'Setelah Gempa',
        steps: [
          'Periksa diri sendiri dan orang di sekitar apakah ada yang terluka, berikan pertolongan pertama jika memungkinkan.',
          'Hindari bangunan yang rusak parah atau berpotensi roboh.',
          'Jauhi area pantai setelah gempa besar karena risiko tsunami.',
          'Dengarkan informasi dan instruksi dari pihak berwenang melalui radio atau sumber terpercaya.',
          'Waspadai gempa susulan dan bahaya lainnya seperti kebakaran atau kebocoran gas.',
        ],
      ),
    ),
    // Add other disaster details here if needed
  };

  @override
  Widget build(BuildContext context) {
    final String? disasterId = Get.parameters['id'];
    final DisasterDetail? disaster = disasterData[disasterId];

    if (disaster == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Disaster not found.')),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  disaster.illustrationAsset,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                title: Text(
                  disaster.title,
                  style: AppTypography.h2.copyWith(color: AppColors.lightText),
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                indicatorColor: AppColors.primary,
                labelColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.lightText
                    : AppColors.inverseText,
                unselectedLabelColor: AppColors.secondaryText,
                tabs: const [
                  Tab(text: 'SEBELUM'),
                  Tab(text: 'SAAT'),
                  Tab(text: 'SETELAH'),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  _buildBeforeTab(context, disaster.before),
                  _buildDuringTab(context, disaster.during),
                  _buildAfterTab(context, disaster.after),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: Tab Views

  Widget _buildBeforeTab(BuildContext context, BeforeData data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.steps.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.solidCircleDot, size: 16, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: AppText.body1(
                  data.steps[index],
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightText
                      : AppColors.inverseText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDuringTab(BuildContext context, DuringData data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.h4(
              data.title,
              textAlign: TextAlign.center,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightText
                  : AppColors.inverseText,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: data.buttonText,
              onPressed: () {
                Get.to(() => EmergencyView(emergencyId: data.emergencyId));
              },
              backgroundColor: AppColors.emergencyRed,
              textColor: AppColors.lightText,
              leadingIcon: FaIcon(FontAwesomeIcons.bell),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAfterTab(BuildContext context, AfterData data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.steps.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.solidCircleCheck, size: 16, color: AppColors.successGreen),
              const SizedBox(width: 12),
              Expanded(
                child: AppText.body1(
                  data.steps[index],
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightText
                      : AppColors.inverseText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// MARK: Data Models

/// Main disaster detail model
class DisasterDetail {
  final String id;
  final String title;
  final String illustrationAsset;
  final BeforeData before;
  final DuringData during;
  final AfterData after;

  const DisasterDetail({
    required this.id,
    required this.title,
    required this.illustrationAsset,
    required this.before,
    required this.during,
    required this.after,
  });
}

/// Data for the 'Before' tab
class BeforeData {
  final String title;
  final List<String> steps;

  const BeforeData({
    required this.title,
    required this.steps,
  });
}

/// Data for the 'During' tab
class DuringData {
  final String title;
  final String buttonText;
  final String emergencyId;

  const DuringData({
    required this.title,
    required this.buttonText,
    required this.emergencyId,
  });
}

/// Data for the 'After' tab
class AfterData {
  final String title;
  final List<String> steps;

  const AfterData({
    required this.title,
    required this.steps,
  });
}
