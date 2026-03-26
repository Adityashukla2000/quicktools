import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;

import 'image_converter_event.dart';
import 'image_converter_state.dart';

class ImageConverterBloc
    extends Bloc<ImageConverterEvent, ImageConverterState> {
  ImageConverterBloc() : super(ImageInitial()) {
    on<ConvertImage>((event, emit) async {
      emit(ImageLoading());

      final image = img.decodeImage(event.bytes);
      if (image != null) {
        int quality = 90;
        Uint8List? output;

        do {
          final jpg = img.encodeJpg(image, quality: quality);
          output = Uint8List.fromList(jpg);

          quality -= 5;
        } while (output.lengthInBytes > event.targetKB * 1024 &&
            quality > 10);

        emit(ImageConverted(
          output,
          originalSize: event.bytes.lengthInBytes,
          compressedSize: output.lengthInBytes,
        ));
      } else {
        emit(ImageError("Invalid Image"));
      }
    });
  }
}