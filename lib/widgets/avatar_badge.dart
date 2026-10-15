import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Circle with user initials.
class AvatarBadge extends StatelessWidget {
  const AvatarBadge({super.key, required this.initials, this.size = 72});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.gradient,
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.36,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
