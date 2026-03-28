import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'image_converter_event.dart';
import 'image_converter_state.dart';

class ImageConverterBloc
    extends Bloc<ImageConverterEvent, ImageConverterState> {
  ImageConverterBloc() : super(ImageInitial()) {
    on<ResetConverter>((event, emit) => emit(ImageInitial()));

    on<ConvertImage>((event, emit) async {
      emit(ImageLoading());
      try {
        int quality = 95;
        Uint8List compressedData = event.bytes;
        CompressFormat targetFormat = event.format;

        // HEIC Web Safety: Browsers can't encode HEIC. Fallback to JPEG.
        if (kIsWeb && targetFormat == CompressFormat.heic) {
          targetFormat = CompressFormat.jpeg;
        }

        // Optimized iterative compression
        while (quality > 10) {
          final result = await FlutterImageCompress.compressWithList(
            event.bytes,
            quality: quality,
            format: targetFormat,
          );

          compressedData = result;

          // Stop if we hit the target size (targetKB * 1024 converts KB to Bytes)
          if (compressedData.lengthInBytes <= event.targetKB * 1024) break;

          // Drop quality by 15% each iteration
          quality -= 15;
        }

        // Sanity Check: Never return a file larger than the original
        // If the "optimized" version is bigger, we return the original bytes
        final bool usedOriginal =
            compressedData.lengthInBytes >= event.bytes.lengthInBytes;
        final finalBytes = usedOriginal ? event.bytes : compressedData;

        emit(
          ImageConverted(
            finalBytes,
            originalSize: event.bytes.lengthInBytes,
            compressedSize: finalBytes.lengthInBytes,
            format: usedOriginal ? CompressFormat.jpeg : targetFormat,
          ),
        );
      } catch (e) {
        emit(
          ImageError(
            "Optimization failed. Please try a different format like JPEG or PNG.",
          ),
        );
      }
    });
  }
}
