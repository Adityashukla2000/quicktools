import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ImageConverterEvent {}

class ConvertImage extends ImageConverterEvent {
  final Uint8List bytes;
  final int targetKB;
  final CompressFormat format;

  ConvertImage(this.bytes, this.targetKB, this.format);
}

class ResetConverter extends ImageConverterEvent {} // For clearing the UI
