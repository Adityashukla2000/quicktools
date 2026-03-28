// ─── Tool Data ────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:quicktools/app/theme.dart';
import 'package:quicktools/features/home/bloc/toolmodel.dart';

import '../model/toolItemmodel.dart';
import '../model/toolcategorymodel.dart';

final List<ToolCategoryModel> toolCategories = [
  ToolCategoryModel(
    title: 'Text Analysis',
    subtitle: 'Check, rewrite & analyze content',
    categoryIcon: Icons.text_fields_rounded,
    accentColor: AppColors.indigo,
    tools: [
      ToolItemModel(
        title: 'Plagiarism Checker',
        tagline: 'Detect duplicate content',
        icon: Icons.plagiarism_outlined,
        color: AppColors.indigo,
      ),
      ToolItemModel(
        title: 'Grammar Checker',
        tagline: 'Fix errors instantly',
        icon: Icons.spellcheck_rounded,
        color: AppColors.violet,
      ),
      ToolItemModel(
        title: 'Word Counter',
        tagline: 'Count words & characters',
        icon: Icons.format_list_numbered_rounded,
        color: AppColors.indigo,
      ),
      ToolItemModel(
        title: 'Paraphrase Tool',
        tagline: 'Rewrite any text',
        icon: Icons.refresh_rounded,
        color: AppColors.violetDark,
      ),
      ToolItemModel(
        title: 'Text Summarizer',
        tagline: 'Summarize long texts',
        icon: Icons.summarize_outlined,
        color: AppColors.indigo,
      ),
      ToolItemModel(
        title: 'AI Detector',
        tagline: 'Spot AI-written content',
        icon: Icons.smart_toy_outlined,
        color: AppColors.violet,
      ),
    ],
  ),
  ToolCategoryModel(
    title: 'Image Editing',
    subtitle: 'Compress, convert & resize images',
    categoryIcon: Icons.image_rounded,
    accentColor: AppColors.sky,
    tools: [
      ToolItemModel(
        title: 'Image Compressor',
        tagline: 'Reduce file size fast',
        icon: Icons.compress_rounded,
        color: AppColors.sky,
        route: "/imageCompressor",
      ),
      ToolItemModel(
        title: 'Image Converter',
        tagline: 'Convert any format',
        icon: Icons.transform_rounded,
        color: AppColors.skyDark,
        route: '/imageFormatter',
      ),
      ToolItemModel(
        title: 'Reverse Image Search',
        tagline: 'Find image sources',
        icon: Icons.image_search_rounded,
        color: AppColors.sky,
      ),
      ToolItemModel(
        title: 'PNG to JPG',
        tagline: 'One-click conversion',
        icon: Icons.photo_rounded,
        color: AppColors.skyDark,
      ),
      ToolItemModel(
        title: 'Crop & Resize',
        tagline: 'Edit dimensions freely',
        icon: Icons.crop_rounded,
        color: AppColors.sky,
      ),
      ToolItemModel(
        title: 'Favicon Generator',
        tagline: 'Create site icons',
        icon: Icons.interests_rounded,
        color: AppColors.skyDark,
      ),
    ],
  ),

  ToolCategoryModel(
    title: 'SEO Tools',
    subtitle: 'Rank higher on search engines',
    categoryIcon: Icons.trending_up_rounded,
    accentColor: AppColors.emerald,
    tools: [
      ToolItemModel(
        title: 'SEO Score Checker',
        tagline: 'Audit your website',
        icon: Icons.score_rounded,
        color: AppColors.emerald,
      ),
      ToolItemModel(
        title: 'Keyword Research',
        tagline: 'Find top keywords',
        icon: Icons.search_rounded,
        color: AppColors.emeraldDark,
      ),
      ToolItemModel(
        title: 'Backlink Checker',
        tagline: 'Analyze your links',
        icon: Icons.link_rounded,
        color: AppColors.emerald,
      ),
      ToolItemModel(
        title: 'Domain Authority',
        tagline: 'Check DA & PA score',
        icon: Icons.domain_rounded,
        color: AppColors.emeraldDark,
      ),
      ToolItemModel(
        title: 'Meta Tag Analyzer',
        tagline: 'Optimize meta tags',
        icon: Icons.tag_rounded,
        color: AppColors.emerald,
      ),
      ToolItemModel(
        title: 'Page Speed Test',
        tagline: 'Measure load times',
        icon: Icons.speed_rounded,
        color: AppColors.emeraldDark,
      ),
    ],
  ),

  ToolCategoryModel(
    title: 'PDF Tools',
    subtitle: 'Merge, split & convert PDFs',
    categoryIcon: Icons.picture_as_pdf_rounded,
    accentColor: AppColors.amber,
    tools: [
      ToolItemModel(
        title: 'Merge PDF',
        tagline: 'Combine multiple PDFs',
        icon: Icons.merge_rounded,
        color: AppColors.amber,
      ),
      ToolItemModel(
        title: 'Compress PDF',
        tagline: 'Shrink PDF file size',
        icon: Icons.compress_rounded,
        color: AppColors.amberDark,
      ),
      ToolItemModel(
        title: 'PDF to Word',
        tagline: 'Edit your PDF easily',
        icon: Icons.article_outlined,
        color: AppColors.amber,
      ),
      ToolItemModel(
        title: 'Word to PDF',
        tagline: 'Convert docs to PDF',
        icon: Icons.picture_as_pdf_rounded,
        color: AppColors.amberDark,
      ),
      ToolItemModel(
        title: 'Split PDF',
        tagline: 'Extract PDF pages',
        icon: Icons.call_split_rounded,
        color: AppColors.amber,
      ),
      ToolItemModel(
        title: 'Unlock PDF',
        tagline: 'Remove PDF password',
        icon: Icons.lock_open_rounded,
        color: AppColors.amberDark,
      ),
    ],
  ),

  ToolCategoryModel(
    title: 'AI Writing',
    subtitle: 'Generate content with AI',
    categoryIcon: Icons.auto_awesome_rounded,
    accentColor: AppColors.rose,
    tools: [
      ToolItemModel(
        title: 'AI Essay Writer',
        tagline: 'Write essays in seconds',
        icon: Icons.edit_note_rounded,
        color: AppColors.rose,
      ),
      ToolItemModel(
        title: 'AI Humanizer',
        tagline: 'Make AI text natural',
        icon: Icons.person_outline_rounded,
        color: AppColors.roseDark,
      ),
      ToolItemModel(
        title: 'Title Generator',
        tagline: 'Create catchy titles',
        icon: Icons.title_rounded,
        color: AppColors.rose,
      ),
      ToolItemModel(
        title: 'AI Story Writer',
        tagline: 'Generate unique stories',
        icon: Icons.auto_stories_rounded,
        color: AppColors.roseDark,
      ),
      ToolItemModel(
        title: 'AI Email Writer',
        tagline: 'Draft emails fast',
        icon: Icons.mail_outline_rounded,
        color: AppColors.rose,
      ),
      ToolItemModel(
        title: 'Paragraph Generator',
        tagline: 'Expand your ideas',
        icon: Icons.privacy_tip,
        color: AppColors.roseDark,
      ),
    ],
  ),
];
