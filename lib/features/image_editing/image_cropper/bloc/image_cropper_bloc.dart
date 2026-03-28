import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:typed_data';

import 'image_cropper_event.dart';
import 'image_cropper_state.dart';

/// Background Worker: Offloads File I/O to a separate Isolate
Future<Uint8List> _processFileToBytes(String path) async {
  final file = CroppedFile(path);
  return await file.readAsBytes();
}

class ImageCropperBloc extends Bloc<ImageCropperEvent, ImageCropperState> {
  ImageCropperBloc() : super(CropInitial()) {
    on<ResetCrop>((event, emit) => emit(CropInitial()));

    on<StartCrop>((event, emit) async {
      emit(CropLoading());
      try {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: event.path,
          compressFormat: ImageCompressFormat.png, // Pro-level quality
          compressQuality: 100,
          uiSettings: [
            // --- Advanced Web UI Implementation ---
            WebUiSettings(
              context: event.context,
              presentStyle: WebPresentStyle.dialog,
              size: const CropperSize(width: 520, height: 520),
              initialAspectRatio: 2 / 3, // Your custom Pro 2:3 ratio
              background: true,
              guides: true,
              center: true,
              zoomable: true,
              movable: true,
              rotatable: true,
              scalable: true,
              cropBoxResizable: true,
              cropBoxMovable: true,
              translations: const WebTranslations(
                title: 'Professional Image Editor',
                rotateLeftTooltip: 'Rotate 90° Left',
                rotateRightTooltip: 'Rotate 90° Right',
                cancelButton: 'Discard',
                cropButton: 'Apply Changes',
              ),
              themeData: WebThemeData(
                rotateLeftIcon: Icons.rotate_left_rounded,
                rotateRightIcon: Icons.rotate_right_rounded,
                doneIcon: Icons.check_circle_outline,
                backIcon: Icons.arrow_back_ios_new,
                rotateIconColor: const Color(0xFF3B82F6), // Pro Blue
                scaleSliderMinValue: 1.0,
                scaleSliderMaxValue: 3.0,
                scaleSliderDivisions: 10,
              ),
            ),
            // Android UI to match
            AndroidUiSettings(
              toolbarTitle: 'Edit Image',
              toolbarColor: const Color(0xFF3B82F6),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
        );

        if (croppedFile != null) {
          // --- ISOLATE USAGE ---
          // compute() spawns an isolate to read bytes without jank
          final Uint8List bytes = await compute(
            _processFileToBytes,
            croppedFile.path,
          );

          emit(CropSuccess(bytes));
        } else {
          emit(CropInitial());
        }
      } catch (e) {
        emit(CropError("Processing failed. Please check file format."));
      }
    });
  }
}
