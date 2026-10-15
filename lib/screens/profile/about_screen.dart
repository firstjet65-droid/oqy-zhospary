import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_logo.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(KkStrings.about)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.l),
          children: const [
            Center(child: AppLogo(size: 88)),
            SizedBox(height: Gaps.l),
            Text(
              KkStrings.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: Gaps.xs),
            Text(
              '${KkStrings.versionLabel} ${KkStrings.version}',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            SizedBox(height: Gaps.xl),
            _InfoBlock(
              title: KkStrings.aboutTopicTitle,
              text: KkStrings.aboutTopic,
            ),
            SizedBox(height: Gaps.m),
            _InfoBlock(
              title: KkStrings.aboutGoalTitle,
              text: KkStrings.aboutGoal,
            ),
            SizedBox(height: Gaps.m),
            _InfoBlock(
              title: KkStrings.aboutAudienceTitle,
              text: KkStrings.aboutAudience,
            ),
            SizedBox(height: Gaps.m),
            _InfoBlock(
              title: KkStrings.aboutFeaturesTitle,
              text: KkStrings.aboutFeatures,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: Gaps.s),
          Text(
            text,
            style: const TextStyle(height: 1.4, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
