import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.sunLight,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                children: [
                  const Icon(Icons.stars, size: 14, color: AppColors.sunDark),
                  const SizedBox(width: 4),
                  Text(
                    '1,240',
                    style: TextStyle(
                      color: AppColors.sunDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _LocationBar()
              .animate()
              .fadeIn(duration: 300.ms),
          const SizedBox(height: AppSpacing.md),
          _WeatherHero()
              .animate()
              .fadeIn(duration: 400.ms, delay: 100.ms)
              .slideY(begin: 0.1, end: 0),
          const SizedBox(height: AppSpacing.lg),
          _AdviceCard()
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms)
              .slideY(begin: 0.1, end: 0),
          const SizedBox(height: AppSpacing.xl),
          Text(
            "Today's tasks",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
          const SizedBox(height: AppSpacing.md),
          _TaskCard(
            icon: Icons.water_drop_outlined,
            iconColor: AppColors.sky,
            iconBg: AppColors.skyLight,
            title: 'Check seedling moisture',
            subtitle: 'Soil should feel damp 2 cm down',
            points: 10,
          ).animate().fadeIn(duration: 300.ms, delay: 400.ms),
          _TaskCard(
            icon: Icons.camera_alt_outlined,
            iconColor: AppColors.sunDark,
            iconBg: AppColors.sunLight,
            title: 'Scan your seedlings',
            subtitle: 'Daily growth check',
            points: 25,
          ).animate().fadeIn(duration: 300.ms, delay: 500.ms),
          _TaskCard(
            icon: Icons.thermostat_outlined,
            iconColor: AppColors.leafDark,
            iconBg: AppColors.leafLight,
            title: 'Log soil temperature',
            subtitle: 'Ideal range 18\u201324\u00b0C',
            points: 15,
          ).animate().fadeIn(duration: 300.ms, delay: 600.ms),
        ],
      ),
    );
  }
}

class _LocationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          'London, UK \u00b7 May',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _WeatherHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.tomatoLight,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning',
            style: TextStyle(
              color: AppColors.tomatoDark,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '17\u00b0',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w600,
                  color: AppColors.tomatoDark,
                  height: 1,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              const Text('\u26c5', style: TextStyle(fontSize: 32)),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Partly cloudy \u00b7 rain tomorrow afternoon',
            style: TextStyle(
              color: AppColors.tomatoDark,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdviceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.skyLight,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border(
          left: BorderSide(color: AppColors.sky, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.water_drop_outlined,
            size: 22,
            color: AppColors.skyDark,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Skip watering today',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.skyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Rain expected tomorrow will cover your Cherokee Carbon seedlings',
                  style: TextStyle(
                    color: AppColors.skyDark.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.points,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+$points',
            style: TextStyle(
              color: AppColors.sunDark,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
