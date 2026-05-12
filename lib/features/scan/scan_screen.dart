import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _selectedStage = 'Seedling';
  bool _scanning = false;
  bool _showResult = false;

  static const _stages = [
    'Seedling',
    'Seed',
    'Leaves',
    'Flower',
    'Fruit',
    'Soil',
  ];

  Future<void> _runScan() async {
    setState(() {
      _scanning = true;
      _showResult = false;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _scanning = false;
      _showResult = true;
    });
  }

  void _resetScan() {
    setState(() {
      _showResult = false;
      _scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan and diagnose'),
        leading: _showResult
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _resetScan,
              )
            : null,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _showResult
            ? _ResultView(stage: _selectedStage, key: const ValueKey('result'))
            : _ScanView(
                key: const ValueKey('scan'),
                stages: _stages,
                selectedStage: _selectedStage,
                onStageChanged: (s) => setState(() => _selectedStage = s),
                scanning: _scanning,
                onCapture: _runScan,
              ),
      ),
    );
  }
}

class _ScanView extends StatelessWidget {
  const _ScanView({
    super.key,
    required this.stages,
    required this.selectedStage,
    required this.onStageChanged,
    required this.scanning,
    required this.onCapture,
  });

  final List<String> stages;
  final String selectedStage;
  final ValueChanged<String> onStageChanged;
  final bool scanning;
  final VoidCallback onCapture;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          'Snap your seed, seedling, leaves or fruit. The AI will tell you what to do.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stages.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (_, i) {
              final stage = stages[i];
              final selected = stage == selectedStage;
              return GestureDetector(
                onTap: () => onStageChanged(stage),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.tomatoLight : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(
                      color: selected ? AppColors.tomato : AppColors.border,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    stage,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: selected
                          ? AppColors.tomatoDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AspectRatio(
          aspectRatio: 3 / 4,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2A),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Center(
              child: scanning
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Analysing...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Hold steady. Point at one plant.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 13,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: scanning ? null : onCapture,
                icon: const Icon(Icons.camera_alt, size: 18),
                label: const Text('Capture'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tomato,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: scanning ? null : () {},
                icon: const Icon(Icons.upload, size: 18),
                label: const Text('Upload'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.border, width: 0.5),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.skyLight,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border(left: BorderSide(color: AppColors.sky, width: 3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline,
                  size: 18, color: AppColors.skyDark),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Each scan earns 25 pts. Daily scans build your growth diary.',
                  style: TextStyle(
                    color: AppColors.skyDark,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({super.key, required this.stage});
  final String stage;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.leafLight,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              const Text('OK', style: TextStyle(fontSize: 36)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Healthy $stage detected',
                      style: TextStyle(
                        color: AppColors.leafDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Cherokee Carbon, day 18 of 75',
                      style: TextStyle(
                        color: AppColors.leafDark.withValues(alpha: 0.85),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.leaf,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: const Text(
                  '94%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: AppSpacing.lg),
        const Text(
          'What to do today',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.md),
        _ActionCard(
          icon: Icons.water_drop_outlined,
          bg: AppColors.skyLight,
          dark: AppColors.skyDark,
          title: 'Water lightly',
          body: 'Soil is dry 2 cm down. Use 50 ml at the base.',
        ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
        _ActionCard(
          icon: Icons.wb_sunny_outlined,
          bg: AppColors.sunLight,
          dark: AppColors.sunDark,
          title: 'Move out of direct sun',
          body: 'Forecast shows 22 degrees this afternoon, too hot for tender seedlings.',
        ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
        _ActionCard(
          icon: Icons.event_outlined,
          bg: AppColors.leafLight,
          dark: AppColors.leafDark,
          title: 'Plan ahead',
          body: 'Ready to transplant in 3 weeks once nights stay above 12 degrees.',
        ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.sunLight,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              const Icon(Icons.stars, color: AppColors.sunDark),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '+25 points earned',
                      style: TextStyle(
                        color: AppColors.sunDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '3-day streak, +5 bonus',
                      style: TextStyle(
                        color: AppColors.sunDark.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.bg,
    required this.dark,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color bg;
  final Color dark;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border(left: BorderSide(color: dark, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: dark, size: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: dark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: TextStyle(
                    color: dark.withValues(alpha: 0.85),
                    fontSize: 12,
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