import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme.dart';

class GardenScreen extends StatelessWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My garden'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            '2 active plants \u00b7 stage progression',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _PlantCard(
            name: 'Cherokee Carbon',
            stage: 'Seedling',
            dayNumber: 18,
            totalDays: 75,
            progress: 0.24,
            progressColor: AppColors.tomato,
            badge: 'On track',
            badgeColor: AppColors.leaf,
            badgeBg: AppColors.leafLight,
            nextStep: 'Transplant in ~3 weeks',
            emoji: '\ud83c\udf45',
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: AppSpacing.md),
          _PlantCard(
            name: 'Sungold',
            stage: 'Germination',
            dayNumber: 6,
            totalDays: 70,
            progress: 0.08,
            progressColor: AppColors.sun,
            badge: 'Watch moisture',
            badgeColor: AppColors.sunDark,
            badgeBg: AppColors.sunLight,
            nextStep: 'Thin to strongest sprout',
            emoji: '\ud83c\udf31',
          ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Stages unlocked',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: Column(
              children: [
                _StageRow(
                  number: '1',
                  title: 'Seed starter',
                  subtitle: 'First sowing logged',
                  points: '+50 pts',
                  unlocked: true,
                ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
                _Divider(),
                _StageRow(
                  number: '2',
                  title: 'Sprout watcher',
                  subtitle: 'Logged 5 daily scans',
                  points: '+75 pts',
                  unlocked: true,
                ).animate().fadeIn(duration: 300.ms, delay: 350.ms),
                _Divider(),
                _StageRow(
                  number: '3',
                  title: 'Transplant master',
                  subtitle: 'Move 1 plant outdoors',
                  points: '+150 pts',
                  unlocked: false,
                ).animate().fadeIn(duration: 300.ms, delay: 400.ms),
                _Divider(),
                _StageRow(
                  number: '4',
                  title: 'First flower',
                  subtitle: 'Photograph a blossom',
                  points: '+100 pts',
                  unlocked: false,
                ).animate().fadeIn(duration: 300.ms, delay: 450.ms),
                _Divider(),
                _StageRow(
                  number: '5',
                  title: 'Harvest hero',
                  subtitle: 'Log your first ripe tomato',
                  points: '+300 pts',
                  unlocked: false,
                ).animate().fadeIn(duration: 300.ms, delay: 500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlantCard extends StatelessWidget {
  const _PlantCard({
    required this.name,
    required this.stage,
    required this.dayNumber,
    required this.totalDays,
    required this.progress,
    required this.progressColor,
    required this.badge,
    required this.badgeColor,
    required this.badgeBg,
    required this.nextStep,
    required this.emoji,
  });

  final String name;
  final String stage;
  final int dayNumber;
  final int totalDays;
  final double progress;
  final Color progressColor;
  final String badge;
  final Color badgeColor;
  final Color badgeBg;
  final String nextStep;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.tomatoLight,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$stage \u00b7 day $dayNumber of ~$totalDays',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.cream,
              valueColor: AlwaysStoppedAnimation(progressColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.arrow_forward,
                size: 12,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Next: $nextStep',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StageRow extends StatelessWidget {
  const _StageRow({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.unlocked,
  });

  final String number;
  final String title;
  final String subtitle;
  final String points;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: unlocked ? AppColors.leafLight : AppColors.cream,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: unlocked
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.leafDark,
                    )
                  : Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: unlocked
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: TextStyle(
              color: unlocked
                  ? AppColors.sunDark
                  : AppColors.textTertiary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      color: AppColors.border,
    );
  }
}
