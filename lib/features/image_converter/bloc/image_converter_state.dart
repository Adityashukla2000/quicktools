import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ImageConverterState {}

class ImageInitial extends ImageConverterState {}

class ImageLoading extends ImageConverterState {}

class ImageConverted extends ImageConverterState {
  final Uint8List bytes;
  final int originalSize;
  final int compressedSize;
  final CompressFormat format;

  ImageConverted(
    this.bytes, {
    required this.originalSize,
    required this.compressedSize,
    required this.format,
  });
}

class ImageError extends ImageConverterState {
  final String message;
  ImageError(this.message);
}
