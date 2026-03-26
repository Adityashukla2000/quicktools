import 'dart:typed_data';

abstract class ImageConverterState {}

class ImageInitial extends ImageConverterState {}

class ImageLoading extends ImageConverterState {}

class ImageConverted extends ImageConverterState {
  final Uint8List bytes;

  final int originalSize;
  final int compressedSize;

  ImageConverted(this.bytes,
      {required this.originalSize, required this.compressedSize});
}

class ImageError extends ImageConverterState {
  final String message;
  ImageError(this.message);
}