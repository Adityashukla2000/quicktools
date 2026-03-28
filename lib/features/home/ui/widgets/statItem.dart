// ─── Helpers ──────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:quicktools/app/theme.dart';

class StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;
  const StatItem({
    super.key,
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
          color: isDark ? AppColors.textPrimDark : AppColors.textPrimLight,
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: isDark ? AppColors.textSecDark : AppColors.textSecLight,
        ),
      ),
    ],
  );
}
