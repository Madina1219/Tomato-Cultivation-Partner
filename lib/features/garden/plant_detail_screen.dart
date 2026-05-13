import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Detail screen for a single tomato plant.
/// Receives plant data from the Garden tab and animates in with a
/// Hero transition for the plant's emoji + name. The Hero tag matches
/// the tag set on the source card in garden_screen.dart so Flutter can
/// morph the shared element between routes.
class PlantDetailScreen extends StatelessWidget {
  final String heroTag;
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

  const PlantDetailScreen({
    super.key,
    required this.heroTag,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero header — large emoji and plant name that morphed in from Garden card
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: progressColor,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Hero(
                tag: '${heroTag}_title',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [progressColor.withValues(alpha: 0.7), progressColor],
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: '${heroTag}_emoji',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 96),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Body content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stage badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        color: badgeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),

                  const SizedBox(height: 24),

                  // Stage info
                  Text(
                    'Current stage',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stage,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

                  const SizedBox(height: 24),

                  // Progress card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Day $dayNumber of $totalDays',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${(progress * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: progressColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Animated progress bar
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: progress),
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 10,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation(progressColor),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 24),

                  // Next step card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: progressColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: progressColor.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: progressColor),
                            const SizedBox(width: 8),
                            Text(
                              'Next step',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: progressColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          nextStep,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 700.ms, delay: 300.ms).slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 32),

                  // Action button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Coming soon: log a care action 🌱'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: progressColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text(
                        'Log a care action',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}