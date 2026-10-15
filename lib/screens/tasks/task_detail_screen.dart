import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/empty_state.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final task = MockData.taskById(taskId);
    if (task == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const EmptyState(message: KkStrings.noTasks),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(KkStrings.taskDetail),
        actions: [
          IconButton(
            tooltip: KkStrings.edit,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push(AppRoutes.addTask),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.l),
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: Gaps.s),
                  Text(
                    task.description,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: Gaps.l),
                  Text(
                    '${KkStrings.progress}: ${(task.progress * 100).round()} %',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: Gaps.s),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: task.progress,
                      minHeight: 10,
                      backgroundColor: AppColors.border,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Gaps.m),
            AppCard(
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.menu_book_outlined,
                    label: KkStrings.subject,
                    value: task.subject,
                  ),
                  _InfoRow(
                    icon: Icons.event_outlined,
                    label: KkStrings.deadline,
                    value: KkDate.withYear(task.deadline),
                  ),
                  _InfoRow(
                    icon: Icons.flag_outlined,
                    label: KkStrings.priority,
                    value: task.priority.label,
                    valueColor: task.priority.color,
                  ),
                  _InfoRow(
                    icon: Icons.info_outline_rounded,
                    label: KkStrings.status,
                    value: task.status.label,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Gaps.xl),
            AppButton(
              label: KkStrings.markDone,
              icon: Icons.check_rounded,
              onPressed: () {
                showAppSnackBar(context, KkStrings.markedDone);
                context.pop();
              },
            ),
            const SizedBox(height: Gaps.m),
            OutlinedButton.icon(
              onPressed: () => context.push(AppRoutes.addTask),
              icon: const Icon(Icons.edit_outlined),
              label: const Text(KkStrings.edit),
            ),
            const SizedBox(height: Gaps.m),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.danger,
              ),
              onPressed: () {
                showAppSnackBar(context, KkStrings.taskDeleted);
                context.pop();
              },
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text(KkStrings.delete),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gaps.s),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: Gaps.m),
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(width: Gaps.m),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
