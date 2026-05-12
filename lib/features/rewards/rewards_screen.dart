import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            'Earn points. Redeem at partner garden shops.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _BalanceCard()
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.1, end: 0),
          const SizedBox(height: AppSpacing.xl),
          const Text(
            'Vouchers you can redeem',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _RewardCard(
            icon: Icons.eco,
            iconColor: AppColors.leafDark,
            iconBg: AppColors.leafLight,
            title: 'Free heirloom seed pack',
            partner: 'RHS Garden Shop, 1,000 pts',
            redeemable: true,
          ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
          _RewardCard(
            icon: Icons.science_outlined,
            iconColor: AppColors.leafDark,
            iconBg: AppColors.leafLight,
            title: 'Five pounds off organic soil mix',
            partner: 'B and Q Garden, 1,200 pts',
            redeemable: true,
          ).animate().fadeIn(duration: 300.ms, delay: 150.ms),
          _RewardCard(
            icon: Icons.local_florist,
            iconColor: AppColors.skyDark,
            iconBg: AppColors.skyLight,
            title: 'Free terracotta pot',
            partner: 'Wyevale Nurseries, 1,500 pts',
            redeemable: false,
          ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
          _RewardCard(
            icon: Icons.build_outlined,
            iconColor: AppColors.tomatoDark,
            iconBg: AppColors.tomatoLight,
            title: 'Pruning tool set',
            partner: 'Crocus.co.uk, 3,000 pts',
            redeemable: false,
          ).animate().fadeIn(duration: 300.ms, delay: 250.ms),
          const SizedBox(height: AppSpacing.xl),
          const Text(
            'Ways to earn faster',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _EarnCard(
            icon: Icons.local_fire_department,
            iconColor: AppColors.tomato,
            iconBg: AppColors.tomatoLight,
            title: 'Keep your daily scan streak',
            subtitle: 'Plus 5 bonus pts each day, plus 50 weekly',
          ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
          _EarnCard(
            icon: Icons.people_outline,
            iconColor: AppColors.leafDark,
            iconBg: AppColors.leafLight,
            title: 'Invite a friend',
            subtitle: 'Plus 200 pts when they log first plant',
          ).animate().fadeIn(duration: 300.ms, delay: 350.ms),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your balance',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              Text(
                '760 to next tier',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '1,240',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'pts',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: 0.62,
              backgroundColor: AppColors.cream,
              valueColor: AlwaysStoppedAnimation(AppColors.tomato),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.sunLight,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  'Silver grower',
                  style: TextStyle(
                    color: AppColors.sunDark,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '760 pts to Gold',
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

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.partner,
    required this.redeemable,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String partner;
  final bool redeemable;

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
            width: 44,
            height: 44,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  partner,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: redeemable
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$title redeemed!'),
                        backgroundColor: AppColors.leafDark,
                      ),
                    );
                  }
                : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: BorderSide(color: AppColors.border, width: 0.5),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            child: Text(redeemable ? 'Redeem' : 'Locked'),
          ),
        ],
      ),
    );
  }
}

class _EarnCard extends StatelessWidget {
  const _EarnCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

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
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }
}