import 'package:flutter/material.dart';
import 'package:quicktools/app/theme.dart';
import 'package:quicktools/features/home/ui/widgets/toolcard.dart';
import 'package:quicktools/features/utils/extension.dart';

import '../model/toolcategorymodel.dart';

// ─── Category Section ──────────────────────────────────────────────────────────
class CategorySection extends StatelessWidget {
  final ToolCategoryModel category;
  final bool isDark;

  const CategorySection({required this.category, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: category.accentColor.withOpacity(isDark ? 0.18 : 0.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  category.categoryIcon,
                  color: category.accentColor,
                  size: 17,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: isDark
                            ? AppColors.textPrimDark
                            : AppColors.textPrimLight,
                      ),
                    ),
                    Text(
                      category.subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textSecDark
                            : AppColors.textSecLight,
                      ),
                    ),
                  ],
                ),
              ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Text(
              //     'See all →',
              //     style: TextStyle(
              //       fontSize: 12,
              //       fontWeight: FontWeight.w600,
              //       color: category.accentColor,
              //     ),
              //   ),
              // ),
            ],
          ),

          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.toolGridColumns,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.88,
            ),
            itemCount: category.tools.length,
            itemBuilder: (_, i) =>
                ToolCardWidget(tool: category.tools[i], isDark: isDark),
          ),
          const SizedBox(height: 18),
          Container(
            height: 0.5,
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ],
      ),
    );
  }
}
