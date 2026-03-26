import 'dart:typed_data';

abstract class ImageConverterEvent {}

class ConvertImage extends ImageConverterEvent {
  final Uint8List bytes;
  ConvertImage(this.bytes);
}