import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ImageFormatterState {}

class FormatterInitial extends ImageFormatterState {}

class FormatterLoading extends ImageFormatterState {}

class FormatterSuccess extends ImageFormatterState {
  final Uint8List bytes;
  final int originalSize;
  final int formattedSize;
  final CompressFormat format;
  final String outputFileName;

  FormatterSuccess({
    required this.bytes,
    required this.originalSize,
    required this.formattedSize,
    required this.format,
    required this.outputFileName,
  });
}

class FormatterError extends ImageFormatterState {
  final String message;
  FormatterError(this.message);
}
