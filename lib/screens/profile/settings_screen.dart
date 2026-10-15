import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/app_card.dart';

/// UI showcase: switches have no real effect.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark = false;
  bool _push = true;
  bool _sound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.settings)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.l),
          children: [
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode_outlined),
                    title: const Text(KkStrings.darkTheme),
                    value: _dark,
                    activeThumbColor: AppColors.primary,
                    onChanged: (v) => setState(() => _dark = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_active_outlined),
                    title: const Text(KkStrings.pushNotifications),
                    value: _push,
                    activeThumbColor: AppColors.primary,
                    onChanged: (v) => setState(() => _push = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.volume_up_outlined),
                    title: const Text(KkStrings.sound),
                    value: _sound,
                    activeThumbColor: AppColors.primary,
                    onChanged: (v) => setState(() => _sound = v),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    minTileHeight: 56,
                    leading: Icon(Icons.language_rounded),
                    title: Text(KkStrings.language),
                    trailing: Text(
                      KkStrings.languageValue,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
