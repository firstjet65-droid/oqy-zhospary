import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/date_utils.dart';
import '../models/task_item.dart';
import 'app_card.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.onTap});

  final TaskItem task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDone = task.status == TaskStatus.done;
    final isOverdue = task.status == TaskStatus.overdue;
    final badgeColor = isDone
        ? AppColors.success
        : isOverdue
        ? AppColors.danger
        : AppColors.primary;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Gaps.m),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 56,
            decoration: BoxDecoration(
              color: task.priority.color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: Gaps.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: Gaps.xs),
                Text(
                  task.subject,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Gaps.s),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isDone ? task.status.label : KkDate.relative(task.deadline),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: badgeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
