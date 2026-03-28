import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:quicktools/app/theme.dart';
import 'package:quicktools/features/home/ui/model/toolItemmodel.dart';

// ─── Tool Card ─────────────────────────────────────────────────────────────
class ToolCardWidget extends StatefulWidget {
  final ToolItemModel tool;
  final bool isDark;
  final VoidCallback? onTap;

  const ToolCardWidget({
    super.key,
    required this.tool,
    required this.isDark,
    this.onTap,
  });

  @override
  State<ToolCardWidget> createState() => _ToolCardState();
}

class _ToolCardState extends State<ToolCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.93,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        HapticFeedback.lightImpact();
        widget.onTap?.call();
        context.push(widget.tool.route);
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDark
                ? AppColors.surfaceDark
                : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: widget.isDark
                  ? AppColors.borderDark
                  : AppColors.borderLight,
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isDark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 13, 10, 11),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: widget.tool.color.withOpacity(
                      widget.isDark ? 0.16 : 0.1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.tool.icon,
                    color: widget.tool.color,
                    size: 19,
                  ),
                ),

                const SizedBox(height: 8),

                // Title
                Text(
                  widget.tool.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: widget.isDark
                        ? AppColors.textPrimDark
                        : AppColors.textPrimLight,
                  ),
                ),
                const SizedBox(height: 3),

                // Tagline
                Text(
                  widget.tool.tagline,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9.5,
                    height: 1.3,
                    color: widget.isDark
                        ? AppColors.textHintDark
                        : AppColors.textHintLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
