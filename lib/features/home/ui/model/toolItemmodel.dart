// ─── Models ───────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

class ToolItemModel {
  final String title;
  final String tagline;
  final IconData icon;
  final Color color;
  final String route;

  const ToolItemModel({
    required this.title,
    required this.tagline,
    required this.icon,
    required this.color,
    this.route = '/',
  });
}
