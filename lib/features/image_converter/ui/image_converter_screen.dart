import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data';
import 'dart:html' as html;

import '../../../app/app.dart';
import '../bloc/image_converter_bloc.dart';
import '../bloc/image_converter_event.dart';
import '../bloc/image_converter_state.dart';

// Assuming these are your App constants based on HomeScreen
// Replace with your actual imports
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/theme_cubit.dart';

class ImageConverterScreen extends StatefulWidget {
  const ImageConverterScreen({super.key});

  @override
  State<ImageConverterScreen> createState() => _ImageConverterScreenState();
}

class _ImageConverterScreenState extends State<ImageConverterScreen> {
  Uint8List? selectedImage;
  int targetKB = 100;
  CompressFormat selectedFormat = CompressFormat.jpeg;

  void _handleRemove(BuildContext context) {
    setState(() {
      selectedImage = null;
      targetKB = 100;
      selectedFormat = CompressFormat.jpeg;
    });
    context.read<ImageConverterBloc>().add(ResetConverter());
  }

  void _downloadWeb(Uint8List bytes, String ext) {
    final extension = ext == 'jpeg' ? 'jpg' : ext;
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute(
        "download",
        "optimized_${DateTime.now().millisecondsSinceEpoch}.$extension",
      )
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    // Detect Theme using your Cubit
    final isDark = context.watch<ThemeCubit>().state;
    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);

    return BlocProvider(
      create: (context) => ImageConverterBloc(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Image Optimizer",
            style: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<ImageConverterBloc, ImageConverterState>(
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDark
                          ? Colors.white10
                          : Colors.black.withOpacity(0.05),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        _buildUploadArea(context, isDark, textColor),
                        const SizedBox(height: 32),
                        _buildSettingsRow(isDark, textColor),
                        const SizedBox(height: 32),
                        _buildActionSection(context, state, isDark),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUploadArea(BuildContext context, bool isDark, Color textColor) {
    return GestureDetector(
      onTap: () async {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true,
        );
        if (result != null)
          setState(() => selectedImage = result.files.first.bytes);
      },
      child: DottedBorder(
        options: RectDottedBorderOptions(
          color: isDark
              ? Colors.blueAccent.withOpacity(0.4)
              : Colors.blueAccent.withOpacity(0.2),
          strokeWidth: 2,
          dashPattern: const [10, 5],
        ),
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.blueAccent.withOpacity(0.02)
                : Colors.blueAccent.withOpacity(0.01),
            borderRadius: BorderRadius.circular(16),
          ),
          child: selectedImage == null
              ? _buildPlaceholder(textColor)
              : _buildPreview(context),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.add_photo_alternate_outlined,
          size: 64,
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 16),
        Text(
          "Click to Upload Image",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        Text(
          "JPG, PNG, WebP supported",
          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPreview(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.memory(
            selectedImage!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: GestureDetector(
            onTap: () => _handleRemove(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsRow(bool isDark, Color textColor) {
    return Row(
      children: [
        Expanded(
          child: _buildDropdown<int>(
            "Target Size",
            targetKB,
            [50, 100, 200, 500]
                .map((v) => DropdownMenuItem(value: v, child: Text("$v KB")))
                .toList(),
            (v) => setState(() => targetKB = v!),
            isDark,
            textColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDropdown<CompressFormat>(
            "Format",
            selectedFormat,
            CompressFormat.values
                .map(
                  (f) => DropdownMenuItem(
                    value: f,
                    child: Text(f.name.toUpperCase()),
                  ),
                )
                .toList(),
            (v) => setState(() => selectedFormat = v!),
            isDark,
            textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>(
    String label,
    T value,
    List<DropdownMenuItem<T>> items,
    ValueChanged<T?> onChanged,
    bool isDark,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: textColor.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.1),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              isExpanded: true,
              dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              style: GoogleFonts.inter(color: textColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(
    BuildContext context,
    ImageConverterState state,
    bool isDark,
  ) {
    if (selectedImage == null) return const SizedBox.shrink();

    final isLoading = state is ImageLoading;

    return Column(
      children: [
        if (state is ImageConverted) _buildResultCard(state, isDark),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  context.read<ImageConverterBloc>().add(
                    ConvertImage(selectedImage!, targetKB, selectedFormat),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: state is ImageConverted
                ? Colors.green
                : Colors.blueAccent,
            minimumSize: const Size(double.infinity, 64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                )
              : Text(
                  state is ImageConverted
                      ? "Optimize Again"
                      : "Start Optimization",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
        ),
        if (state is ImageConverted) ...[
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => _downloadWeb(state.bytes, selectedFormat.name),
            icon: const Icon(Icons.download, size: 20),
            label: const Text("Download Optimized File"),
            style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          ),
        ],
      ],
    );
  }

  Widget _buildResultCard(ImageConverted state, bool isDark) {
    final savings = ((1 - (state.compressedSize / state.originalSize)) * 100)
        .toStringAsFixed(0);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(isDark ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statTile("Original", state.originalSize, isDark),
              const Icon(
                Icons.keyboard_double_arrow_right_rounded,
                color: Colors.green,
              ),
              _statTile(
                "Optimized",
                state.compressedSize,
                isDark,
                isHighlight: true,
              ),
            ],
          ),
          const Divider(height: 40),
          Text(
            "You saved $savings% storage space!",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statTile(
    String label,
    int bytes,
    bool isDark, {
    bool isHighlight = false,
  }) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
        Text(
          "${(bytes / 1024).toStringAsFixed(1)} KB",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isHighlight
                ? Colors.blueAccent
                : (isDark ? Colors.white : Colors.black87),
          ),
        ),
      ],
    );
  }
}
