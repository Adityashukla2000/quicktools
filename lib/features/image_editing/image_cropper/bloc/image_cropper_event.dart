// Events
import 'package:flutter/material.dart';

// Events
abstract class ImageCropperEvent {}
class StartCrop extends ImageCropperEvent {
  final String path;
  final BuildContext context;
  StartCrop(this.path, this.context);
}
class ResetCrop extends ImageCropperEvent {}