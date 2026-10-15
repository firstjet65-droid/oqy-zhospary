import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/lesson_tile.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  /// 1 = Monday ... 7 = Sunday
  int _selectedDay = DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    final lessons = MockData.lessonsForDay(_selectedDay);
    final monday = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );

    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.tabSchedule)),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: KkStrings.addLesson,
        onPressed: () => context.push(AppRoutes.addLesson),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 84,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Gaps.l),
                itemCount: 7,
                separatorBuilder: (_, __) => const SizedBox(width: Gaps.s),
                itemBuilder: (context, i) {
                  final date = monday.add(Duration(days: i));
                  return _DayChip(
                    label: KkStrings.weekdaysShort[i],
                    dayNumber: date.day,
                    selected: _selectedDay == i + 1,
                    onTap: () => setState(() => _selectedDay = i + 1),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Gaps.l,
                Gaps.s,
                Gaps.l,
                Gaps.s,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  KkDate.weekdays[_selectedDay - 1],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: lessons.isEmpty
                  ? const EmptyState(
                      message: KkStrings.noLessonsDay,
                      icon: Icons.event_busy_rounded,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        Gaps.l,
                        Gaps.s,
                        Gaps.l,
                        88,
                      ),
                      itemCount: lessons.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: Gaps.s),
                      itemBuilder: (_, i) => LessonTile(lesson: lessons[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.label,
    required this.dayNumber,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int dayNumber;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: 52,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white70 : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: Gaps.xs),
              Text(
                '$dayNumber',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
