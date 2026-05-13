import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import 'plant_detail_screen.dart';

/// GardenScreen lists the user's tomato plants from Firestore in real-time.
/// Plants are stored at /users/{uid}/plants/{plantId} and protected by
/// security rules that match the signed-in Firebase Auth user.
class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  final AuthService _auth = AuthService();
  FirestoreService? _firestore;

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      _firestore = FirestoreService(uid: uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_firestore == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My garden'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddPlantSheet,
        icon: const Icon(Icons.add),
        label: const Text('Add plant'),
        backgroundColor: AppColors.tomato,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _firestore!.watchPlants(),
        builder: (context, snapshot) {
          // Loading state on first connection to Firestore.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state - rules denied, network failure, etc.
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Couldn't load your garden: ${snapshot.error}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final plants = snapshot.data ?? const [];

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(
                plants.isEmpty
                    ? 'No plants yet \u00b7 add your first tomato'
                    : '${plants.length} active plant${plants.length == 1 ? '' : 's'} \u00b7 stage progression',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Empty state when no plants exist.
              if (plants.isEmpty) _buildEmptyState(),

              // One card per plant. Each card is now wrapped in a tappable
              // Hero widget so it can morph into a detail screen on tap.
              // The staggered animation makes cards fade in one by one.
              ...plants.asMap().entries.map((entry) {
                final i = entry.key;
                final p = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _tappablePlantCard(context, p)
                      .animate()
                      .fadeIn(
                        duration: 400.ms,
                        delay: (100 * i).ms,
                      )
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        duration: 400.ms,
                        delay: (100 * i).ms,
                        curve: Curves.easeOutCubic,
                      ),
                );
              }),

              const SizedBox(height: AppSpacing.xl),

              // Achievements section preserved unchanged from original design.
              const Text(
                'Stages unlocked',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
              const SizedBox(height: AppSpacing.md),
              _buildStagesContainer(),
            ],
          );
        },
      ),
    );
  }

  // -------------------- Empty state --------------------

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          const Text('\u{1F331}', style: TextStyle(fontSize: 48)),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Your garden is empty',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Tap "Add plant" to log your first tomato.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ------------------- Firestore -> _PlantCard adapter --------------------

  /// Converts a plant document from Firestore into a styled _PlantCard widget.
  /// Stage-aware colour and badge logic lives here so the data layer stays
  /// pure (strings + numbers) and the visual mapping is one place.
  _PlantCard _plantCardFromFirestore(Map<String, dynamic> data) {
    final stage = (data['stage'] as String?) ?? 'Seedling';
    final dayCount = (data['dayCount'] as num?)?.toInt() ?? 0;
    final totalDays = (data['totalDays'] as num?)?.toInt() ?? 75;
    final progress = totalDays == 0
        ? 0.0
        : (dayCount / totalDays).clamp(0.0, 1.0).toDouble();

    // Stage-aware colour scheme.
    Color progressColor;
    Color badgeColor;
    Color badgeBg;
    String badge;
    String emoji;
    switch (stage.toLowerCase()) {
      case 'germination':
        progressColor = AppColors.sun;
        badgeColor = AppColors.sunDark;
        badgeBg = AppColors.sunLight;
        badge = 'Watch moisture';
        emoji = '\u{1F331}';
        break;
      case 'flowering':
        progressColor = AppColors.leaf;
        badgeColor = AppColors.leafDark;
        badgeBg = AppColors.leafLight;
        badge = 'Pollinating';
        emoji = '\u{1F33C}';
        break;
      case 'fruiting':
        progressColor = AppColors.tomato;
        badgeColor = AppColors.tomato;
        badgeBg = AppColors.tomatoLight;
        badge = 'Ripening';
        emoji = '\u{1F345}';
        break;
      case 'seedling':
      default:
        progressColor = AppColors.tomato;
        badgeColor = AppColors.leaf;
        badgeBg = AppColors.leafLight;
        badge = 'On track';
        emoji = '\u{1F345}';
    }

    return _PlantCard(
      name: (data['variety'] as String?) ?? 'Unnamed plant',
      stage: stage,
      dayNumber: dayCount,
      totalDays: totalDays,
      progress: progress,
      progressColor: progressColor,
      badge: badge,
      badgeColor: badgeColor,
      badgeBg: badgeBg,
      nextStep: _nextStepForStage(stage),
      emoji: emoji,
    );
  }

  /// Tappable wrapper for a plant card.
  ///
  /// Builds the same _PlantCard, then wraps it in a Hero widget (for
  /// shared element transitions when navigating to the detail screen)
  /// and a GestureDetector (for tap-to-navigate gesture recognition).
  /// The Hero tag is unique per plant — uses the Firestore document ID
  /// if available, otherwise falls back to a composite of variety + dayCount.
  Widget _tappablePlantCard(BuildContext context, Map<String, dynamic> data) {
    final card = _plantCardFromFirestore(data);
    final variety = (data['variety'] as String?) ?? 'Unnamed plant';
    final dayCount = (data['dayCount'] as num?)?.toInt() ?? 0;
    final totalDays = (data['totalDays'] as num?)?.toInt() ?? 75;
    final stage = (data['stage'] as String?) ?? 'Seedling';
    final progress = totalDays == 0
        ? 0.0
        : (dayCount / totalDays).clamp(0.0, 1.0).toDouble();

    final heroTag =
        'plant_${(data['id'] as String?) ?? '${variety}_$dayCount'}';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PlantDetailScreen(
              heroTag: heroTag,
              name: variety,
              stage: stage,
              dayNumber: dayCount,
              totalDays: totalDays,
              progress: progress,
              progressColor: card.progressColor,
              badge: card.badge,
              badgeColor: card.badgeColor,
              badgeBg: card.badgeBg,
              nextStep: card.nextStep,
              emoji: card.emoji,
            ),
          ),
        );
      },
      child: Hero(
        tag: heroTag,
        child: Material(
          color: Colors.transparent,
          child: card,
        ),
      ),
    );
  }

  String _nextStepForStage(String stage) {
    switch (stage.toLowerCase()) {
      case 'germination':
        return 'Thin to strongest sprout';
      case 'flowering':
        return 'Support stems as fruit forms';
      case 'fruiting':
        return 'Harvest when fully coloured';
      case 'seedling':
      default:
        return 'Transplant in ~3 weeks';
    }
  }

  // -------------------- Add plant bottom sheet --------------------

  void _showAddPlantSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (sheetContext) => _AddPlantSheet(
        onSave: (variety, stage, dayCount) async {
          await _firestore!.savePlant(
            variety: variety,
            stage: stage,
            dayCount: dayCount,
            extras: {'totalDays': 75},
          );
          if (sheetContext.mounted) Navigator.pop(sheetContext);
        },
      ),
    );
  }

  // -------------------- Stages unlocked (unchanged from original) --------------------

  Widget _buildStagesContainer() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: const Column(
        children: [
          _StageRow(
            number: '1',
            title: 'Seed starter',
            subtitle: 'First sowing logged',
            points: '+50 pts',
            unlocked: true,
          ),
          _Divider(),
          _StageRow(
            number: '2',
            title: 'Sprout watcher',
            subtitle: 'Logged 5 daily scans',
            points: '+75 pts',
            unlocked: true,
          ),
          _Divider(),
          _StageRow(
            number: '3',
            title: 'Transplant master',
            subtitle: 'Move 1 plant outdoors',
            points: '+150 pts',
            unlocked: false,
          ),
          _Divider(),
          _StageRow(
            number: '4',
            title: 'First flower',
            subtitle: 'Photograph a blossom',
            points: '+100 pts',
            unlocked: false,
          ),
          _Divider(),
          _StageRow(
            number: '5',
            title: 'Harvest hero',
            subtitle: 'Log your first ripe tomato',
            points: '+300 pts',
            unlocked: false,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Existing widgets preserved unchanged from the original design.
// _PlantCard, _StageRow, _Divider keep their original look and feel; only
// the data source above changed from hardcoded values to Firestore stream.
// =====================================================================

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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '$stage \u00b7 day $dayNumber of ~$totalDays',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
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
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: AppColors.cream,
              valueColor: AlwaysStoppedAnimation(progressColor),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.arrow_forward,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                'Next: $nextStep',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
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
        horizontal: AppSpacing.lg,
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
                  ? const Icon(Icons.check, size: 16, color: AppColors.leafDark)
                  : const Icon(Icons.lock_outline,
                      size: 14, color: AppColors.textTertiary),
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
                        : AppColors.textTertiary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: TextStyle(
              color: unlocked ? AppColors.tomato : AppColors.textTertiary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, color: AppColors.border);
}

// =====================================================================
// Add plant bottom sheet - simple form to log a new tomato.
// =====================================================================

class _AddPlantSheet extends StatefulWidget {
  const _AddPlantSheet({required this.onSave});

  final Future<void> Function(String variety, String stage, int dayCount) onSave;

  @override
  State<_AddPlantSheet> createState() => _AddPlantSheetState();
}

class _AddPlantSheetState extends State<_AddPlantSheet> {
  final _varietyController = TextEditingController();
  final _dayController = TextEditingController(text: '1');
  String _stage = 'Seedling';
  bool _saving = false;

  static const _stages = [
    'Germination',
    'Seedling',
    'Flowering',
    'Fruiting',
  ];

  @override
  void dispose() {
    _varietyController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_varietyController.text.trim().isEmpty || _saving) return;
    setState(() => _saving = true);
    await widget.onSave(
      _varietyController.text.trim(),
      _stage,
      int.tryParse(_dayController.text.trim()) ?? 1,
    );
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a plant',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _varietyController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Variety',
              hintText: 'e.g. Cherokee Carbon',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            initialValue: _stage,
            decoration: const InputDecoration(
              labelText: 'Stage',
              border: OutlineInputBorder(),
            ),
            items: _stages
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => _stage = v ?? 'Seedling'),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _dayController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Days since sowing',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _saving ? null : _handleSave,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.tomato,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Save plant'),
            ),
          ),
        ],
      ),
    );
  }
}