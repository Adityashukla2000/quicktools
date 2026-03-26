// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// // ─── Theme Cubit (keep your existing one) ────────────────────────────────────
// class ThemeCubit extends Cubit<bool> {
//   ThemeCubit() : super(false);
//   void toggle() => emit(!state);
// }



// // ─── ToolCard Widget (updated version of your original) ───────────────────────
// class ToolCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final VoidCallback onTap;
//   final Color? color;

//   const ToolCard({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.onTap,
//     this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final cardColor = color ?? const Color(0xFF6366F1);

//     return _ToolCard(
//       tool: ToolItem(title: title, icon: icon, color: cardColor),
//       isDark: isDark,
//       onTap: onTap,
//     );
//   }
// }


