import 'package:flutter/material.dart';
import 'package:quicktools/app/theme.dart';
import 'package:quicktools/features/home/ui/model/toolItemmodel.dart';
import 'package:quicktools/features/home/ui/widgets/toolcard.dart';

class Divider extends StatelessWidget {
  final bool isDark;

  const Divider({required this.isDark});

  @override
  Widget build(BuildContext context) => Container(
    width: 0.5,
    height: 26,
    margin: const EdgeInsets.symmetric(horizontal: 18),
    color: isDark ? AppColors.borderDark : AppColors.borderLight,
  );
}

// ─── Public ToolCard widget ───────────────────────────────────────────────────
class ToolCard extends StatelessWidget {
  final String title;
  final String tagline;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const ToolCard({
    super.key,
    required this.title,
    required this.tagline,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ToolCardWidget(
      tool: ToolItemModel(
        title: title,
        tagline: tagline,
        icon: icon,
        color: color ?? AppColors.indigo,
      ),
      isDark: isDark,
    );
  }
}
