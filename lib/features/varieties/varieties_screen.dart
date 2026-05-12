import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme.dart';
import 'variety_detail_screen.dart';

class VarietiesScreen extends StatefulWidget {
  const VarietiesScreen({super.key});

  @override
  State<VarietiesScreen> createState() => _VarietiesScreenState();
}

class _VarietiesScreenState extends State<VarietiesScreen> {
  List<Map<String, dynamic>> _all = [];
  List<Map<String, dynamic>> _filtered = [];
  String _selectedFilter = 'For my zone';
  bool _loading = true;

  static const _filters = [
    'For my zone',
    'Cherry',
    'Slicer',
    'Heirloom',
    'Paste',
  ];

  // London is roughly USDA zone 8-9
  static const _userZone = 8;
  static const _userMonth = 5; // May

  @override
  void initState() {
    super.initState();
    _loadVarieties();
  }

  Future<void> _loadVarieties() async {
    final raw = await rootBundle.loadString('assets/varieties.json');
    final list = (json.decode(raw) as List).cast<Map<String, dynamic>>();
    setState(() {
      _all = list;
      _applyFilter();
      _loading = false;
    });
  }

  void _applyFilter() {
    if (_selectedFilter == 'For my zone') {
      _filtered = _all.where((v) {
        final zones = (v['zonesGood'] as List).cast<int>();
        return zones.contains(_userZone);
      }).toList();
    } else {
      _filtered = _all.where((v) {
        return v['category'] == _selectedFilter ||
            v['type'] == _selectedFilter;
      }).toList();
    }
  }

  String _matchBadge(Map<String, dynamic> v) {
    final zones = (v['zonesGood'] as List).cast<int>();
    final monthsGood = (v['monthsGood'] as List).cast<int>();
    final monthsOk = (v['monthsOk'] as List).cast<int>();

    if (zones.contains(_userZone) && monthsGood.contains(_userMonth)) {
      return 'Great match';
    } else if (zones.contains(_userZone) && monthsOk.contains(_userMonth)) {
      return 'Decent match';
    } else {
      return 'Cool nights';
    }
  }

  Color _badgeColor(String badge) {
    switch (badge) {
      case 'Great match':
        return AppColors.leaf;
      case 'Decent match':
        return AppColors.sun;
      default:
        return AppColors.sky;
    }
  }

  Color _badgeBg(String badge) {
    switch (badge) {
      case 'Great match':
        return AppColors.leafLight;
      case 'Decent match':
        return AppColors.sunLight;
      default:
        return AppColors.skyLight;
    }
  }

  String _emojiFor(String category) {
    switch (category) {
      case 'Cherry':
      case 'Grape':
        return '\ud83c\udf45';
      case 'Paste':
        return '\ud83c\udf45';
      default:
        return '\ud83c\udf45';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Varieties'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.tomato),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${_filtered.length} varieties \u00b7 ${_selectedFilter.toLowerCase()}',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (_, i) {
                      final filter = _filters[i];
                      final selected = filter == _selectedFilter;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter;
                            _applyFilter();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.tomatoLight
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(
                              color: selected
                                  ? AppColors.tomato
                                  : AppColors.border,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            filter,
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
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final v = _filtered[i];
                      final badge = _matchBadge(v);
                      return _VarietyCard(
                        variety: v,
                        badge: badge,
                        badgeColor: _badgeColor(badge),
                        badgeBg: _badgeBg(badge),
                        emoji: _emojiFor(v['category'] as String),
                      ).animate().fadeIn(
                            duration: 300.ms,
                            delay: (i * 30).ms,
                          );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _VarietyCard extends StatelessWidget {
  const _VarietyCard({
    required this.variety,
    required this.badge,
    required this.badgeColor,
    required this.badgeBg,
    required this.emoji,
  });

  final Map<String, dynamic> variety;
  final String badge;
  final Color badgeColor;
  final Color badgeBg;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    final id = variety['id'] as String;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => VarietyDetailScreen(variety: variety),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'variety_$id',
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.tomatoLight,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              variety['name'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '${variety['category']} \u00b7 ${variety['type']}',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 2,
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
      ),
    );
  }
}
