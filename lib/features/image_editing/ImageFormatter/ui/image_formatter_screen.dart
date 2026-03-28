import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:html' as html if (dart.library.html) 'dart:html';

// Replace these with your actual bloc imports
import '../bloc/image_formatter_bloc.dart';
import '../bloc/image_formatter_event.dart';
import '../bloc/image_formatter_state.dart';

class ImageFormatterScreen extends StatefulWidget {
  const ImageFormatterScreen({super.key});

  @override
  State<ImageFormatterScreen> createState() => _ImageFormatterScreenState();
}

class _ImageFormatterScreenState extends State<ImageFormatterScreen> {
  Uint8List? selectedImage;
  String? selectedFileName;
  CompressFormat selectedFormat = CompressFormat.png;

  void _handleRemove(BuildContext context) {
    setState(() {
      selectedImage = null;
      selectedFileName = null;
    });
    // Assuming your Bloc has a reset event, otherwise omit
    // context.read<ImageFormatterBloc>().add(ResetFormatter());
  }

  void _downloadWeb(Uint8List bytes, String fileName) {
    if (kIsWeb) {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme detection logic from first UI
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);

    return BlocProvider(
      create: (context) => ImageFormatterBloc(),
      child: Scaffold(
        backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Image Converter",
            style: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<ImageFormatterBloc, ImageFormatterState>(
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 40),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
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
                      mainAxisSize: MainAxisSize.min,
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
        if (result != null) {
          setState(() {
            selectedImage = result.files.first.bytes;
            selectedFileName = result.files.first.name;
          });
        }
      },
      child: DottedBorder(
        options: RectDottedBorderOptions(
          color: isDark ? Colors.blueAccent.withOpacity(0.4) : Colors.blueAccent.withOpacity(0.2),
          strokeWidth: 2,
          dashPattern: const [10, 5],
        ),
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? Colors.blueAccent.withOpacity(0.02) : Colors.blueAccent.withOpacity(0.01),
            borderRadius: BorderRadius.circular(16),
          ),
          child: selectedImage == null ? _buildPlaceholder(textColor) : _buildPreview(context),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.add_photo_alternate_outlined, size: 64, color: Colors.blueAccent),
        const SizedBox(height: 16),
        Text(
          "Click to Upload Image",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textColor),
        ),
        Text(
          "All standard formats supported",
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
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsRow(bool isDark, Color textColor) {
    final formats = CompressFormat.values.where((f) => kIsWeb ? f != CompressFormat.heic : true).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Target Format",
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
            child: DropdownButton<CompressFormat>(
              value: selectedFormat,
              isExpanded: true,
              dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              style: GoogleFonts.inter(color: textColor),
              items: formats
                  .map((f) => DropdownMenuItem(
                        value: f,
                        child: Text(f.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => selectedFormat = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(BuildContext context, ImageFormatterState state, bool isDark) {
    if (selectedImage == null) return const SizedBox.shrink();
    final isLoading = state is FormatterLoading;

    return Column(
      children: [
        if (state is FormatterSuccess) _buildResultCard(state, isDark),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  context.read<ImageFormatterBloc>().add(FormatImage(
                        bytes: selectedImage!,
                        format: selectedFormat,
                        fileName: selectedFileName!,
                      ));
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: state is FormatterSuccess ? Colors.green : Colors.blueAccent,
            minimumSize: const Size(double.infinity, 64),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
              : Text(
                  state is FormatterSuccess ? "Format Again" : "Start Formatting",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
        ),
        if (state is FormatterSuccess) ...[
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => _downloadWeb(state.bytes, state.outputFileName),
            icon: const Icon(Icons.download, size: 20),
            label: const Text("Download Formatted File"),
            style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          ),
        ],
      ],
    );
  }

  Widget _buildResultCard(FormatterSuccess state, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(isDark ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Converted to ${selectedFormat.name.toUpperCase()} successfully!",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}