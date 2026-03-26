import 'dart:typed_data';

abstract class ImageConverterEvent {}

class ConvertImage extends ImageConverterEvent {
  final Uint8List bytes;
  final int targetKB;

  ConvertImage(this.bytes, this.targetKB);
}