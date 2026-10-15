import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = MockData.notifications;
    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.notifications)),
      body: SafeArea(
        child: items.isEmpty
            ? const EmptyState(
                message: KkStrings.noNotifications,
                icon: Icons.notifications_off_outlined,
              )
            : ListView.separated(
                padding: const EdgeInsets.all(Gaps.l),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: Gaps.s),
                itemBuilder: (_, i) {
                  final n = items[i];
                  return AppCard(
                    padding: const EdgeInsets.all(Gaps.m),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: n.color.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(n.icon, color: n.color),
                        ),
                        const SizedBox(width: Gaps.m),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                n.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: Gaps.xs),
                              Text(
                                n.body,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: Gaps.xs),
                              Text(
                                n.time,
                                style: const TextStyle(
                                  fontSize: 12,
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
