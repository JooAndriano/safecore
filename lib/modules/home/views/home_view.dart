import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';
import '../../../routes/app_pages.dart';
import '../../medical/views/medical_list_view.dart';
import '../../disaster/views/disaster_list_view.dart';
import '../../emergency/views/emergency_view.dart';

/// Home Screen - Halaman utama SAFECORE
/// Struktur: Header + Search, Quick Actions, Kategori Utama, Akses Cepat Grid
class HomeView extends StatelessWidget {
  HomeView({super.key});

  // MARK: Data

  /// Quick action items
  final List<QuickActionItem> quickActions = [
    QuickActionItem(
      title: 'Hubungi\nDarurat',
      icon: FontAwesomeIcons.phone,
      color: AppColors.emergencyRed,
      isPrimary: true,
    ),
    QuickActionItem(
      title: 'Senter',
      icon:

      FontAwesomeIcons.bolt, // Replacement for flashlight which might be missing
      color: AppColors.warningYellow,
    ),
    QuickActionItem(
      title: 'Bagikan\nLokasi',
      icon: FontAwesomeIcons.locationPin,
      color: AppColors.infoBlue,
    ),
  ];

  /// Main category items
  final List<CategoryItem> mainCategories = [
    const CategoryItem(
      title: 'Darurat Medis',
      subtitle: 'Panduan pertolongan pertama',
      icon: '🚑',
      color: AppColors.emergencyRed,
      route: '/medical',
    ),
    const CategoryItem(
      title: 'Bencana Alam',
      subtitle: 'Siapsiagaan bencana',
      icon: '🌋',
      color: AppColors.emergencyOrange,
      route: '/disaster',
    ),
  ];

  /// Quick access grid items
  final List<QuickAccessItem> quickAccessItems = [
    QuickAccessItem(
      title: 'Pingsan',
      icon: FontAwesomeIcons.angleDown,
      color: AppColors.infoBlue,
      route: '/medical/fainting',
    ),
    QuickAccessItem(
      title: 'Pendarahan',
      icon: FontAwesomeIcons.droplet,
      color: AppColors.emergencyRed,
      route: '/medical/bleeding',
    ),
    QuickAccessItem(
      title: 'Gempa',
      icon: FontAwesomeIcons.houseChimneyCrack,
      color: AppColors.emergencyOrange,
      route: '/disaster/earthquake',
    ),
    QuickAccessItem(
      title: 'Banjir',
      icon: FontAwesomeIcons.water,
      color: AppColors.infoBlue,
      route: '/disaster/flood',
    ),
    QuickAccessItem(
      title: 'Kebakaran',
      icon: FontAwesomeIcons.fire,
      color: AppColors.emergencyRed,
      route: '/disaster/fire',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // MARK: SliverAppBar - Header + Search
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(''),
              centerTitle: true,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.bell,
                      size: 20,
                      color: AppColors.lightText,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.emergencyRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SAFECORE',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.emergencyRed,
                      ),
                    ),
                    const Text(
                      'Asisten Darurat Pribadi',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSearchBar(context),
                  ],
                ),
              ),
            ),
          ),

          // MARK: Quick Actions - Horizontal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: quickActions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final action = entry.value;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index < quickActions.length - 1 ? 8 : 0,
                      ),
                      child: _buildQuickAction(context, action),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // MARK: Kategori Utama - 2 Kartu Besar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'Kategori',
                style: AppTypography.h3.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightText
                      : AppColors.inverseText,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCategories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(context, mainCategories[index]);
                  },
                ),
              ),
            ),
          ),

          // MARK: Akses Cepat - Grid 3 Kolom
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Akses Cepat',
                style: AppTypography.h3.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightText
                      : AppColors.inverseText,
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildQuickAccessCard(context, quickAccessItems[index]);
              },
              childCount: quickAccessItems.length,
            ),
          ),

          // MARK: Bottom padding for navigation bar
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }

  // MARK: Widgets

  /// Search bar widget
  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/search'),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSurfaceVariant
              : AppColors.lightSurfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari bantuan...',
            prefixIcon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 18,
              color: AppColors.secondaryText,
            ),
            suffixIcon: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.sliders,
                size: 18,
                color: AppColors.secondaryText,
              ),
              onPressed: () {},
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
          readOnly: true,
        ),
      ),
    );
  }

  /// Quick action button widget
  Widget _buildQuickAction(BuildContext context, QuickActionItem action) {
    return GestureDetector(
      onTap: () => _handleQuickAction(action),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: action.isPrimary
              ? AppColors.emergencyRed
              : Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: action.isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.emergencyRed.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (action.icon is FaIconData)
              FaIcon(
                action.icon as FaIconData,
                size: 24,
                color: action.isPrimary
                    ? AppColors.lightText
                    : action.color,
              )
            else if (action.icon is IconData)
              Icon(
                action.icon as IconData,
                size: 24,
                color: action.isPrimary
                    ? AppColors.lightText
                    : action.color,
              )
            else
              const SizedBox.shrink(),
            const SizedBox(height: 4),
            Text(
              action.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: action.isPrimary
                    ? AppColors.lightText
                    : Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightText
                        : AppColors.inverseText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Category card widget
  Widget _buildCategoryCard(BuildContext context, CategoryItem category) {
    return GestureDetector(
      onTap: () => _navigateToRoute(category.route),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color,
              category.color.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: category.color.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.icon,
                style: const TextStyle(fontSize: 32),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category.subtitle,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: AppColors.lightText,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Quick access grid card widget
  Widget _buildQuickAccessCard(BuildContext context, QuickAccessItem item) {
    return GestureDetector(
      onTap: () => _navigateToRoute(item.route),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSurface
              : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: item.color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              item.icon,
              size: 28,
              color: item.color,
            ),
            const SizedBox(height: 6),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.lightText
                    : AppColors.inverseText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: Actions

  /// Handle quick action tap
  void _handleQuickAction(QuickActionItem action) {
    if (action.title.contains('Darurat')) {
      // Gunakan Get.offAllNamed() untuk emergency mode
      // memastikan full screen dan kembali ke /home saat finish
      Get.offAllNamed(AppRoutes.emergency);
    } else if (action.title == 'Senter') {
      Get.snackbar(
        'Senter',
        'Lampu senter dinyalakan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.darkSurface,
        colorText: AppColors.lightText,
      );
    } else if (action.title.contains('Lokasi')) {
      Get.snackbar(
        'Bagikan Lokasi',
        'Lokasi Anda sedang dibagikan...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.darkSurface,
        colorText: AppColors.lightText,
      );
    }
  }

  /// Navigate to route - Menggunakan Get.toNamed() secara konsisten
  /// untuk memastikan navigasi terintegrasi dengan AppPages dan NavController
  void _navigateToRoute(String route) {
    if (route == '/medical') {
      Get.toNamed(AppRoutes.medicalList);
    } else if (route == '/disaster') {
      Get.toNamed(AppRoutes.disasterList);
    } else if (route.startsWith('/medical')) {
      Get.toNamed(route);
    } else if (route.startsWith('/disaster')) {
      Get.toNamed(route);
    }
  }
}

// MARK: Data Models

/// Quick action item model
class QuickActionItem {
  final String title;
  final dynamic icon;
  final Color color;
  final bool isPrimary;

  const QuickActionItem({
    required this.title,
    required this.icon,
    required this.color,
    this.isPrimary = false,
  });
}

/// Category item model
class CategoryItem {
  final String title;
  final String subtitle;
  final String icon;
  final Color color;
  final String route;

  const CategoryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });
}

/// Quick access grid item model
class QuickAccessItem {
  final String title;
  final dynamic icon;
  final Color color;
  final String route;

  const QuickAccessItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
