import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../l10n/kk_strings.dart';

enum TaskPriority {
  low(KkStrings.priorityLow, AppColors.success),
  medium(KkStrings.priorityMedium, AppColors.warning),
  high(KkStrings.priorityHigh, AppColors.danger);

  const TaskPriority(this.label, this.color);
  final String label;
  final Color color;
}

enum TaskStatus {
  active(KkStrings.statusActive),
  done(KkStrings.statusDone),
  overdue(KkStrings.statusOverdue);

  const TaskStatus(this.label);
  final String label;
}

class TaskItem {
  const TaskItem({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.deadline,
    required this.priority,
    required this.status,
    required this.progress,
  });

  final String id;
  final String title;
  final String subject;
  final String description;
  final DateTime deadline;
  final TaskPriority priority;
  final TaskStatus status;

  /// 0.0 - 1.0
  final double progress;
}
