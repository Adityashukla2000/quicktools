import 'package:flutter/material.dart';

class ToolItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const ToolItem({
    required this.title,
    required this.icon,
    required this.color,
    this.route = '/',
  });
}

class ToolCategory {
  final String title;
  final String subtitle;
  final IconData categoryIcon;
  final Color accentColor;
  final List<ToolItem> tools;

  const ToolCategory({
    required this.title,
    required this.subtitle,
    required this.categoryIcon,
    required this.accentColor,
    required this.tools,
  });
}