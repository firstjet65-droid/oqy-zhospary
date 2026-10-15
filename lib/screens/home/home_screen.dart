import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../models/task_item.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/lesson_tile.dart';
import '../../widgets/section_header.dart';
import '../../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final now = DateTime.now();
    final lessons = MockData.lessonsForDay(now.weekday).take(3).toList();
    final deadlines = MockData.tasks
        .where((t) => t.status == TaskStatus.active)
        .take(3)
        .toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${KkStrings.greeting}, ${user?.firstName ?? ''}!'),
            Text(
              KkDate.full(now),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: KkStrings.notifications,
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () => context.push(AppRoutes.notifications),
          ),
          const SizedBox(width: Gaps.xs),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.l),
          children: [
            const _ProgressCard(),
            const SizedBox(height: Gaps.xl),
            const SectionHeader(title: KkStrings.quickActions),
            const _QuickActions(),
            const SizedBox(height: Gaps.xl),
            SectionHeader(
              title: KkStrings.todayLessons,
              actionLabel: KkStrings.fullSchedule,
              onAction: () => context.go(AppRoutes.schedule),
            ),
            if (lessons.isEmpty)
              const EmptyState(
                message: KkStrings.noLessonsToday,
                icon: Icons.event_busy_rounded,
              )
            else
              for (final lesson in lessons) ...[
                LessonTile(lesson: lesson),
                const SizedBox(height: Gaps.s),
              ],
            const SizedBox(height: Gaps.l),
            SectionHeader(
              title: KkStrings.upcomingDeadlines,
              actionLabel: KkStrings.all,
              onAction: () => context.go(AppRoutes.tasks),
            ),
            if (deadlines.isEmpty)
              const EmptyState(message: KkStrings.noTasks)
            else
              for (final task in deadlines) ...[
                TaskTile(
                  task: task,
                  onTap: () => context.push(AppRoutes.taskDetail(task.id)),
                ),
                const SizedBox(height: Gaps.s),
              ],
          ],
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    const value = MockData.overallProgress;
    return AppCard(
      gradient: AppColors.gradient,
      padding: const EdgeInsets.all(Gaps.xl),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  KkStrings.weekProgress,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Gaps.s),
                Text(
                  KkStrings.weekProgressHint,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: Gaps.l),
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 7,
                    color: Colors.white,
                    backgroundColor: Colors.white24,
                  ),
                ),
                Text(
                  '${(value * 100).round()} %',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
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

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.add_task_rounded,
                label: KkStrings.addTask,
                color: AppColors.primary,
                onTap: () => context.push(AppRoutes.addTask),
              ),
            ),
            const SizedBox(width: Gaps.m),
            Expanded(
              child: _ActionButton(
                icon: Icons.more_time_rounded,
                label: KkStrings.addLesson,
                color: AppColors.accent,
                onTap: () => context.push(AppRoutes.addLesson),
              ),
            ),
          ],
        ),
        const SizedBox(height: Gaps.m),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.calendar_month_rounded,
                label: KkStrings.fullSchedule,
                color: AppColors.warning,
                onTap: () => context.go(AppRoutes.schedule),
              ),
            ),
            const SizedBox(width: Gaps.m),
            Expanded(
              child: _ActionButton(
                icon: Icons.bar_chart_rounded,
                label: KkStrings.statistics,
                color: AppColors.success,
                onTap: () => context.go(AppRoutes.stats),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: Gaps.m, vertical: Gaps.m),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: Gaps.s),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
