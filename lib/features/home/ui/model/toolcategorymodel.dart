import 'package:flutter/material.dart';

import 'toolItemmodel.dart';

class ToolCategoryModel {
  final String title;
  final String subtitle;
  final IconData categoryIcon;
  final Color accentColor;
  final List<ToolItemModel> tools;

  const ToolCategoryModel({
    required this.title,
    required this.subtitle,
    required this.categoryIcon,
    required this.accentColor,
    required this.tools,
  });
}
