import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ImageFormatterEvent {}

class FormatImage extends ImageFormatterEvent {
  final Uint8List bytes;
  final CompressFormat format;
  final String fileName;

  FormatImage({
    required this.bytes,
    required this.format,
    required this.fileName,
  });
}

class ResetFormatter extends ImageFormatterEvent {}
