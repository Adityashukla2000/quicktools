import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;

import 'image_converter_event.dart';
import 'image_converter_state.dart';

class ImageConverterBloc
    extends Bloc<ImageConverterEvent, ImageConverterState> {
  ImageConverterBloc() : super(ImageInitial()) {
    on<ConvertImage>((event, emit) {
      final image = img.decodeImage(event.bytes);
      if (image != null) {
        final png = img.encodePng(image);
        emit(ImageConverted(Uint8List.fromList(png)));
      }
    });
  }
}
