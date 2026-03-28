import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:html' as html;

// Assuming your project imports
import '../../../../app/app.dart';
import '../bloc/image_cropper_bloc.dart';
import '../bloc/image_cropper_event.dart';
import '../bloc/image_cropper_state.dart';

class ImageCropperScreen extends StatefulWidget {
  const ImageCropperScreen({super.key});

  @override
  State<ImageCropperScreen> createState() => _ImageCropperScreenState();
}

class _ImageCropperScreenState extends State<ImageCropperScreen> {
  String? _pickedPath;
  Uint8List? _previewBytes;

  @override
  Widget build(BuildContext context) {
    // Advanced Theme Detection via your Cubit
    final isDark = context.watch<ThemeCubit>().state;
    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);

    return BlocProvider(
      create: (context) => ImageCropperBloc(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Advanced Cropper",
            style: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: BlocBuilder<ImageCropperBloc, ImageCropperState>(
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.08)
                          : Colors.black.withOpacity(0.05),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.4 : 0.06),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        _buildUploadArea(context, isDark, textColor, state),
                        const SizedBox(height: 32),
                        if (_pickedPath != null)
                          _buildActionArea(context, state, isDark, textColor),
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

  Widget _buildUploadArea(
    BuildContext context,
    bool isDark,
    Color textColor,
    ImageCropperState state,
  ) {
    final displayImage = (state is CropSuccess) ? state.bytes : _previewBytes;

    return GestureDetector(
      onTap: () async {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true,
        );
        if (result != null) {
          setState(() {
            _pickedPath = result.files.first.path;
            _previewBytes = result.files.first.bytes;
          });
          context.read<ImageCropperBloc>().add(ResetCrop());
        }
      },
      child: DottedBorder(
        // FIXED: Using RectDottedBorderOptions as requested
        options: RectDottedBorderOptions(
          color: isDark
              ? Colors.blueAccent.withOpacity(0.4)
              : Colors.blueAccent.withOpacity(0.2),
          strokeWidth: 2,
          dashPattern: const [10, 5],
        ),
        child: Container(
          height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.blueAccent.withOpacity(0.03)
                : Colors.blueAccent.withOpacity(0.01),
            borderRadius: BorderRadius.circular(20),
          ),
          child: displayImage == null
              ? _buildPlaceholder(textColor)
              : _buildImageDisplay(context, displayImage),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.auto_awesome_motion_rounded,
          size: 54,
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 16),
        Text(
          "Upload Image to Edit",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Custom 2:3 & Square Ratios Supported",
          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildImageDisplay(BuildContext context, Uint8List bytes) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.memory(
            bytes,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: InkWell(
            onTap: () {
              setState(() {
                _pickedPath = null;
                _previewBytes = null;
              });
              context.read<ImageCropperBloc>().add(ResetCrop());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionArea(
    BuildContext context,
    ImageCropperState state,
    bool isDark,
    Color textColor,
  ) {
    final isLoading = state is CropLoading;

    return Column(
      children: [
        if (state is CropSuccess) _buildSuccessCard(isDark),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () => context.read<ImageCropperBloc>().add(
                  StartCrop(_pickedPath!, context),
                ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            minimumSize: const Size(double.infinity, 64),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Text(
                  state is CropSuccess ? "Modify Crop" : "Open Pro Editor",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
        ),
        if (state is CropSuccess) ...[
          const SizedBox(height: 16),
          _buildDownloadButton(state.bytes),
        ],
      ],
    );
  }

  Widget _buildSuccessCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(isDark ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_rounded, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Text(
            "Image Processed Successfully",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton(Uint8List bytes) {
    return InkWell(
      onTap: () => _downloadWeb(bytes),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.file_download_outlined,
              color: Colors.blueAccent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "Download Result",
              style: GoogleFonts.inter(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadWeb(Uint8List bytes) {
    if (!kIsWeb) return;
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute(
        "download",
        "pro_crop_${DateTime.now().millisecondsSinceEpoch}.png",
      )
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
