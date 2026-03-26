import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quicktools/app/app.dart';
import 'package:quicktools/app/theme.dart';
import 'package:quicktools/features/utils/extension.dart';

// ─── Models ───────────────────────────────────────────────────────────────────
class ToolItem {
  final String title;
  final String tagline;
  final IconData icon;
  final Color color;
  final String route;

  const ToolItem({
    required this.title,
    required this.tagline,
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

// ─── Tool Data ────────────────────────────────────────────────────────────────
final List<ToolCategory> toolCategories = [
  ToolCategory(
    title: 'Text Analysis',
    subtitle: 'Check, rewrite & analyze content',
    categoryIcon: Icons.text_fields_rounded,
    accentColor: AppColors.indigo,
    tools: [
      ToolItem(
        title: 'Plagiarism Checker',
        tagline: 'Detect duplicate content',
        icon: Icons.plagiarism_outlined,
        color: AppColors.indigo,
      ),
      ToolItem(
        title: 'Grammar Checker',
        tagline: 'Fix errors instantly',
        icon: Icons.spellcheck_rounded,
        color: AppColors.violet,
      ),
      ToolItem(
        title: 'Word Counter',
        tagline: 'Count words & characters',
        icon: Icons.format_list_numbered_rounded,
        color: AppColors.indigo,
      ),
      ToolItem(
        title: 'Paraphrase Tool',
        tagline: 'Rewrite any text',
        icon: Icons.refresh_rounded,
        color: AppColors.violetDark,
      ),
      ToolItem(
        title: 'Text Summarizer',
        tagline: 'Summarize long texts',
        icon: Icons.summarize_outlined,
        color: AppColors.indigo,
      ),
      ToolItem(
        title: 'AI Detector',
        tagline: 'Spot AI-written content',
        icon: Icons.smart_toy_outlined,
        color: AppColors.violet,
      ),
    ],
  ),
  ToolCategory(
    title: 'Image Editing',
    subtitle: 'Compress, convert & resize images',
    categoryIcon: Icons.image_rounded,
    accentColor: AppColors.sky,
    tools: [
      ToolItem(
        title: 'Image Compressor',
        tagline: 'Reduce file size fast',
        icon: Icons.compress_rounded,
        color: AppColors.sky,
        route: "/imageCompressor",
      ),
      ToolItem(
        title: 'Image Converter',
        tagline: 'Convert any format',
        icon: Icons.transform_rounded,
        color: AppColors.skyDark,
        route: '/image',
      ),
      ToolItem(
        title: 'Reverse Image Search',
        tagline: 'Find image sources',
        icon: Icons.image_search_rounded,
        color: AppColors.sky,
      ),
      ToolItem(
        title: 'PNG to JPG',
        tagline: 'One-click conversion',
        icon: Icons.photo_rounded,
        color: AppColors.skyDark,
      ),
      ToolItem(
        title: 'Crop & Resize',
        tagline: 'Edit dimensions freely',
        icon: Icons.crop_rounded,
        color: AppColors.sky,
      ),
      ToolItem(
        title: 'Favicon Generator',
        tagline: 'Create site icons',
        icon: Icons.interests_rounded,
        color: AppColors.skyDark,
      ),
    ],
  ),

  ToolCategory(
    title: 'SEO Tools',
    subtitle: 'Rank higher on search engines',
    categoryIcon: Icons.trending_up_rounded,
    accentColor: AppColors.emerald,
    tools: [
      ToolItem(
        title: 'SEO Score Checker',
        tagline: 'Audit your website',
        icon: Icons.score_rounded,
        color: AppColors.emerald,
      ),
      ToolItem(
        title: 'Keyword Research',
        tagline: 'Find top keywords',
        icon: Icons.search_rounded,
        color: AppColors.emeraldDark,
      ),
      ToolItem(
        title: 'Backlink Checker',
        tagline: 'Analyze your links',
        icon: Icons.link_rounded,
        color: AppColors.emerald,
      ),
      ToolItem(
        title: 'Domain Authority',
        tagline: 'Check DA & PA score',
        icon: Icons.domain_rounded,
        color: AppColors.emeraldDark,
      ),
      ToolItem(
        title: 'Meta Tag Analyzer',
        tagline: 'Optimize meta tags',
        icon: Icons.tag_rounded,
        color: AppColors.emerald,
      ),
      ToolItem(
        title: 'Page Speed Test',
        tagline: 'Measure load times',
        icon: Icons.speed_rounded,
        color: AppColors.emeraldDark,
      ),
    ],
  ),

  ToolCategory(
    title: 'PDF Tools',
    subtitle: 'Merge, split & convert PDFs',
    categoryIcon: Icons.picture_as_pdf_rounded,
    accentColor: AppColors.amber,
    tools: [
      ToolItem(
        title: 'Merge PDF',
        tagline: 'Combine multiple PDFs',
        icon: Icons.merge_rounded,
        color: AppColors.amber,
      ),
      ToolItem(
        title: 'Compress PDF',
        tagline: 'Shrink PDF file size',
        icon: Icons.compress_rounded,
        color: AppColors.amberDark,
      ),
      ToolItem(
        title: 'PDF to Word',
        tagline: 'Edit your PDF easily',
        icon: Icons.article_outlined,
        color: AppColors.amber,
      ),
      ToolItem(
        title: 'Word to PDF',
        tagline: 'Convert docs to PDF',
        icon: Icons.picture_as_pdf_rounded,
        color: AppColors.amberDark,
      ),
      ToolItem(
        title: 'Split PDF',
        tagline: 'Extract PDF pages',
        icon: Icons.call_split_rounded,
        color: AppColors.amber,
      ),
      ToolItem(
        title: 'Unlock PDF',
        tagline: 'Remove PDF password',
        icon: Icons.lock_open_rounded,
        color: AppColors.amberDark,
      ),
    ],
  ),

  ToolCategory(
    title: 'AI Writing',
    subtitle: 'Generate content with AI',
    categoryIcon: Icons.auto_awesome_rounded,
    accentColor: AppColors.rose,
    tools: [
      ToolItem(
        title: 'AI Essay Writer',
        tagline: 'Write essays in seconds',
        icon: Icons.edit_note_rounded,
        color: AppColors.rose,
      ),
      ToolItem(
        title: 'AI Humanizer',
        tagline: 'Make AI text natural',
        icon: Icons.person_outline_rounded,
        color: AppColors.roseDark,
      ),
      ToolItem(
        title: 'Title Generator',
        tagline: 'Create catchy titles',
        icon: Icons.title_rounded,
        color: AppColors.rose,
      ),
      ToolItem(
        title: 'AI Story Writer',
        tagline: 'Generate unique stories',
        icon: Icons.auto_stories_rounded,
        color: AppColors.roseDark,
      ),
      ToolItem(
        title: 'AI Email Writer',
        tagline: 'Draft emails fast',
        icon: Icons.mail_outline_rounded,
        color: AppColors.rose,
      ),
      ToolItem(
        title: 'Paragraph Generator',
        tagline: 'Expand your ideas',
        icon: Icons.privacy_tip,
        color: AppColors.roseDark,
      ),
    ],
  ),
];

final popularTools = [
  {
    'label': 'Plagiarism Checker',
    'icon': Icons.plagiarism_outlined,
    'color': AppColors.indigo,
  },
  {
    'label': 'Grammar Check',
    'icon': Icons.spellcheck_rounded,
    'color': AppColors.violet,
  },
  {
    'label': 'AI Detector',
    'icon': Icons.smart_toy_outlined,
    'color': AppColors.rose,
  },
  {
    'label': 'Image Compress',
    'icon': Icons.compress_rounded,
    'color': AppColors.sky,
  },
  {'label': 'PDF Merge', 'icon': Icons.merge_rounded, 'color': AppColors.amber},
  {
    'label': 'SEO Checker',
    'icon': Icons.trending_up_rounded,
    'color': AppColors.emerald,
  },
  {
    'label': 'Paraphrase',
    'icon': Icons.refresh_rounded,
    'color': AppColors.violetDark,
  },
  {
    'label': 'Word Counter',
    'icon': Icons.format_list_numbered_rounded,
    'color': AppColors.sky,
  },
];

// ─── HomeScreen ───────────────────────────────────────────────────────────────
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

  List<ToolItem> get _searchResults {
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

  List<ToolCategory> get _visibleCategories => _selectedCategoryIndex < 0
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
                      (cat) => _CategorySection(category: cat, isDark: isDark),
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
              separatorBuilder: (_, __) => const SizedBox(width: 7),
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
            itemBuilder: (_, i) => _ToolCard(tool: results[i], isDark: isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBanner(bool isDark) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upgrade to PRO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Unlimited checks, no ads, priority speed',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.72),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Get PRO',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: AppColors.indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Category Section ──────────────────────────────────────────────────────────
class _CategorySection extends StatelessWidget {
  final ToolCategory category;
  final bool isDark;

  const _CategorySection({required this.category, required this.isDark});

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
                _ToolCard(tool: category.tools[i], isDark: isDark),
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

// ─── Tool Card ─────────────────────────────────────────────────────────────
class _ToolCard extends StatefulWidget {
  final ToolItem tool;
  final bool isDark;
  final VoidCallback? onTap;

  const _ToolCard({required this.tool, required this.isDark, this.onTap});

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard>
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

// ─── Helpers ──────────────────────────────────────────────────────────────────
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;
  const _StatItem({
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

class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

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
    return _ToolCard(
      tool: ToolItem(
        title: title,
        tagline: tagline,
        icon: icon,
        color: color ?? AppColors.indigo,
      ),
      isDark: isDark,
      onTap: onTap,
    );
  }
}
