import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../l10n/kk_strings.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_card.dart';
import '../../widgets/avatar_badge.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(KkStrings.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(KkStrings.no),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(KkStrings.yes),
          ),
        ],
      ),
    );
    // Router redirects to /login after the session is cleared.
    if (confirmed == true) await auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.profile)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.l),
          children: [
            AppCard(
              padding: const EdgeInsets.all(Gaps.xl),
              child: Column(
                children: [
                  AvatarBadge(initials: user?.initials ?? '?'),
                  const SizedBox(height: Gaps.l),
                  Text(
                    user?.fullName ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: Gaps.xs),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  if (user != null) ...[
                    const SizedBox(height: Gaps.s),
                    Text(
                      '${KkStrings.registeredOn}: ${KkDate.withYear(user.createdAt)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: Gaps.l),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _MenuRow(
                    icon: Icons.settings_outlined,
                    label: KkStrings.settings,
                    onTap: () => context.push(AppRoutes.settings),
                  ),
                  const Divider(height: 1),
                  _MenuRow(
                    icon: Icons.notifications_none_rounded,
                    label: KkStrings.notifications,
                    onTap: () => context.push(AppRoutes.notifications),
                  ),
                  const Divider(height: 1),
                  _MenuRow(
                    icon: Icons.menu_book_outlined,
                    label: KkStrings.mySubjects,
                    onTap: () => context.push(AppRoutes.subjects),
                  ),
                  const Divider(height: 1),
                  _MenuRow(
                    icon: Icons.info_outline_rounded,
                    label: KkStrings.about,
                    onTap: () => context.push(AppRoutes.about),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Gaps.l),
            AppCard(
              padding: EdgeInsets.zero,
              child: _MenuRow(
                icon: Icons.logout_rounded,
                label: KkStrings.logout,
                color: AppColors.danger,
                showChevron: false,
                onTap: () => _confirmLogout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppColors.textPrimary,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 56,
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w600, color: color),
      ),
      trailing: showChevron
          ? const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            )
          : null,
      onTap: onTap,
    );
  }
}
