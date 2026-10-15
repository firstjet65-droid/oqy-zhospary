import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/lesson.dart';
import 'app_card.dart';

class LessonTile extends StatelessWidget {
  const LessonTile({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(Gaps.m),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 52,
            decoration: BoxDecoration(
              color: lesson.color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: Gaps.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: Gaps.xs),
                Text(
                  '${lesson.teacher} · ${lesson.room}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Gaps.s),
          Text(
            lesson.timeRange,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: lesson.color,
            ),
          ),
        ],
      ),
    );
  }
}
