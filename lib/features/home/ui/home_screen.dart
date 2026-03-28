import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicktools/app/app.dart';
import 'package:quicktools/app/theme.dart';
import 'package:quicktools/features/home/ui/model/toolcategorymodel.dart';
import 'package:quicktools/features/home/ui/widgets/toolcard.dart';

import 'repo/listitemdata.dart';
import 'repo/popularTools.dart';
import 'widgets/categorysection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  int _selectedCategoryIndex = -1;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<dynamic> get _searchResults {
    if (_query.isEmpty) return [];
    final q = _query.toLowerCase();
    return toolCategories
        .expand((c) => c.tools)
        .where(
          (t) =>
              t.title.toLowerCase().contains(q) ||
              t.tagline.toLowerCase().contains(q),
        )
        .toList();
  }

  List<ToolCategoryModel> get _visibleCategories => _selectedCategoryIndex < 0
      ? toolCategories
      : [toolCategories[_selectedCategoryIndex]];

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(isDark),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHero(isDark),
                  if (_query.isNotEmpty)
                    _buildSearchResults(isDark)
                  else ...[
                    _buildCategoryTabs(isDark),
                    _buildPopularStrip(isDark),
                    ..._visibleCategories.map(
                      (cat) => CategorySection(category: cat, isDark: isDark),
                    ),
                    // _buildFooterBanner(isDark),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(bool isDark) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      toolbarHeight: 58,
      title: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.indigo, AppColors.violet],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: Colors.white,
              size: 17,
            ),
          ),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Quick',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                    color: isDark
                        ? AppColors.textPrimDark
                        : AppColors.textPrimLight,
                  ),
                ),
                const TextSpan(
                  text: 'Tools',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                    color: AppColors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //   margin: const EdgeInsets.only(right: 6),
        //   decoration: BoxDecoration(
        //     color: const Color(0xFFFEF3C7),
        //     borderRadius: BorderRadius.circular(20),
        //     border: Border.all(color: const Color(0xFFFCD34D), width: 0.5),
        //   ),
        //   child: const Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(
        //         Icons.workspace_premium_rounded,
        //         size: 12,
        //         color: Color(0xFFD97706),
        //       ),
        //       SizedBox(width: 3),
        //       Text(
        //         'PRO',
        //         style: TextStyle(
        //           fontSize: 11,
        //           fontWeight: FontWeight.w800,
        //           color: Color(0xFFD97706),
        //           letterSpacing: 0.5,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        GestureDetector(
          onTap: () => context.read<ThemeCubit>().toggle(),
          child: Container(
            width: 34,
            height: 34,
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark2 : AppColors.bgLight,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 0.5,
              ),
            ),
            child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              size: 16,
              color: isDark ? AppColors.textSecDark : AppColors.textSecLight,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(
          height: 0.5,
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
    );
  }

  Widget _buildHero(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.indigo.withOpacity(isDark ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.indigo.withOpacity(0.25),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  size: 12,
                  color: AppColors.indigo,
                ),
                const SizedBox(width: 5),
                const Text(
                  '30+ Free Tools — No Sign Up Required',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.indigo,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Headline
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                height: 1.15,
                color: isDark
                    ? AppColors.textPrimDark
                    : AppColors.textPrimLight,
              ),
              children: const [
                TextSpan(text: 'All the tools you need,\n'),
                TextSpan(
                  text: 'completely free.',
                  style: TextStyle(color: AppColors.indigo),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'SEO · Image editing · PDF · AI writing — in one place',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: isDark ? AppColors.textSecDark : AppColors.textSecLight,
            ),
          ),
          const SizedBox(height: 20),

          // Search
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark2 : AppColors.bgLight,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 13),
                Icon(
                  Icons.search_rounded,
                  size: 17,
                  color: isDark
                      ? AppColors.textHintDark
                      : AppColors.textHintLight,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (v) => setState(() => _query = v),
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.textPrimDark
                          : AppColors.textPrimLight,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search 30+ tools...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.textHintDark
                            : AppColors.textHintLight,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                if (_searchCtrl.text.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() {
                      _searchCtrl.clear();
                      _query = '';
                    }),
                    child: Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.borderDark
                            : const Color(0xFFCBD5E1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 11,
                        color: isDark
                            ? AppColors.textSecDark
                            : AppColors.textSecLight,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 12),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Stats
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     _StatItem(value: '100+', label: 'Free Tools', isDark: isDark),
          //     _Divider(isDark: isDark),
          //     _StatItem(value: '10M+', label: 'Users', isDark: isDark),
          //     _Divider(isDark: isDark),
          //     _StatItem(value: '0', label: 'Sign Ups Needed', isDark: isDark),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(bool isDark) {
    final allLabels = ['All', ...toolCategories.map((c) => c.title)];
    return Container(
      height: 44,
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        itemCount: allLabels.length,
        itemBuilder: (context, i) {
          final selected = _selectedCategoryIndex == i - 1;
          final accent = i == 0
              ? AppColors.indigo
              : toolCategories[i - 1].accentColor;
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selectedCategoryIndex = i - 1);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 7),
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: selected
                    ? accent
                    : (isDark ? AppColors.surfaceDark2 : AppColors.bgLight),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? accent
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  allLabels[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? Colors.white
                        : (isDark
                              ? AppColors.textSecDark
                              : AppColors.textSecLight),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularStrip(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: 13,
                  decoration: BoxDecoration(
                    color: AppColors.indigo,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 7),
                Text(
                  'Most Popular',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    color: isDark
                        ? AppColors.textSecDark
                        : AppColors.textSecLight,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: popularTools.length,
              separatorBuilder: (_, _) => const SizedBox(width: 7),
              itemBuilder: (_, i) {
                final t = popularTools[i];
                final color = t['color'] as Color;
                return GestureDetector(
                  onTap: () => HapticFeedback.selectionClick(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark2
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(t['icon'] as IconData, size: 12, color: color),
                        const SizedBox(width: 5),
                        Text(
                          t['label'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.textSecDark
                                : AppColors.textSecLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(bool isDark) {
    final results = _searchResults;
    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark2 : AppColors.bgLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 26,
                color: isDark
                    ? AppColors.textHintDark
                    : AppColors.textHintLight,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'No tools found for "$_query"',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textSecDark : AppColors.textSecLight,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Try "compress", "checker", or "pdf"',
              style: TextStyle(
                fontSize: 12.5,
                color: isDark
                    ? AppColors.textHintDark
                    : AppColors.textHintLight,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              '${results.length} tools found',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textSecDark : AppColors.textSecLight,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.88,
            ),
            itemCount: results.length,
            itemBuilder: (_, i) =>
                ToolCardWidget(tool: results[i], isDark: isDark),
          ),
        ],
      ),
    );
  }
}
