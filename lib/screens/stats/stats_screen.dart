import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.tabStats)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.l),
          children: [
            const Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: KkStrings.completed,
                    value: '${MockData.statCompleted}',
                    color: AppColors.success,
                    icon: Icons.check_circle_rounded,
                  ),
                ),
                SizedBox(width: Gaps.m),
                Expanded(
                  child: StatCard(
                    label: KkStrings.late,
                    value: '${MockData.statLate}',
                    color: AppColors.danger,
                    icon: Icons.alarm_off_rounded,
                  ),
                ),
                SizedBox(width: Gaps.m),
                Expanded(
                  child: StatCard(
                    label: KkStrings.planned,
                    value: '${MockData.statPlanned}',
                    color: AppColors.primary,
                    icon: Icons.pending_actions_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gaps.xl),
            const SectionHeader(title: KkStrings.weeklyActivity),
            const AppCard(
              child: _WeeklyBarChart(values: MockData.weeklyActivity),
            ),
            const SizedBox(height: Gaps.xl),
            AppCard(
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: Gaps.m),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          KkStrings.mostActiveSubject,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: Gaps.xs),
                        Text(
                          MockData.mostActiveSubject,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: Gaps.xs),
                        Text(
                          KkStrings.mostActiveSubjectHint,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bar chart made of plain Containers (no chart library).
class _WeeklyBarChart extends StatelessWidget {
  const _WeeklyBarChart({required this.values});

  final List<int> values;

  static const double _maxBarHeight = 140;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final today = DateTime.now().weekday - 1;

    return SizedBox(
      height: _maxBarHeight + 52,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < values.length; i++)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${values[i]}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: Gaps.xs),
                  Container(
                    width: 22,
                    height: maxValue == 0
                        ? 4
                        : (values[i] / maxValue * _maxBarHeight).clamp(
                            4,
                            _maxBarHeight,
                          ),
                    decoration: BoxDecoration(
                      color: i == today
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: Gaps.s),
                  Text(
                    KkStrings.weekdaysShort[i],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: i == today
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: i == today
                          ? AppColors.primary
                          : AppColors.textSecondary,
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
