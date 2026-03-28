import 'dart:typed_data';

// States
abstract class ImageCropperState {}
class CropInitial extends ImageCropperState {}
class CropLoading extends ImageCropperState {}
class CropSuccess extends ImageCropperState {
  final Uint8List bytes;
  CropSuccess(this.bytes);
}
class CropError extends ImageCropperState {
  final String message;
  CropError(this.message);
}