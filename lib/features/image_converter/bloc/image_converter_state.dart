import 'dart:typed_data';

abstract class ImageConverterState {}

class ImageInitial extends ImageConverterState {}

class ImageConverted extends ImageConverterState {
  final Uint8List bytes;
  ImageConverted(this.bytes);
}