import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../models/task_item.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/task_tile.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  /// null = all
  TaskStatus? _filter;

  static const _filters = <(String, TaskStatus?)>[
    (KkStrings.all, null),
    (KkStrings.filterActive, TaskStatus.active),
    (KkStrings.filterDone, TaskStatus.done),
    (KkStrings.filterOverdue, TaskStatus.overdue),
  ];

  @override
  Widget build(BuildContext context) {
    final tasks = MockData.tasks
        .where((t) => _filter == null || t.status == _filter)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.tabTasks)),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: KkStrings.addTask,
        onPressed: () => context.push(AppRoutes.addTask),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: Gaps.l,
                  vertical: Gaps.s,
                ),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: Gaps.s),
                itemBuilder: (context, i) {
                  final (label, status) = _filters[i];
                  final selected = _filter == status;
                  return ChoiceChip(
                    label: Text(label),
                    selected: selected,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    onSelected: (_) => setState(() => _filter = status),
                  );
                },
              ),
            ),
            Expanded(
              child: tasks.isEmpty
                  ? const EmptyState(message: KkStrings.noTasks)
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        Gaps.l,
                        Gaps.s,
                        Gaps.l,
                        88,
                      ),
                      itemCount: tasks.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: Gaps.s),
                      itemBuilder: (_, i) => TaskTile(
                        task: tasks[i],
                        onTap: () =>
                            context.push(AppRoutes.taskDetail(tasks[i].id)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
