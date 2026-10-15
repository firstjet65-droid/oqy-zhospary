import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/empty_state.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const subjects = MockData.subjects;
    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.mySubjects)),
      body: SafeArea(
        child: subjects.isEmpty
            ? const EmptyState(message: KkStrings.noSubjects)
            : ListView.separated(
                padding: const EdgeInsets.all(Gaps.l),
                itemCount: subjects.length,
                separatorBuilder: (_, __) => const SizedBox(height: Gaps.s),
                itemBuilder: (_, i) {
                  final s = subjects[i];
                  return AppCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Gaps.l,
                      vertical: Gaps.m,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: s.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: Gaps.m),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: Gaps.xs),
                              Text(
                                s.teacher,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
