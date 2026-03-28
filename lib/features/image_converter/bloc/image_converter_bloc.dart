import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'image_converter_event.dart';
import 'image_converter_state.dart';

// Parameters for the Isolate
class CompressionParams {
  final Uint8List bytes;
  final int targetKB;
  final CompressFormat format;

  CompressionParams(this.bytes, this.targetKB, this.format);
}

class ImageConverterBloc
    extends Bloc<ImageConverterEvent, ImageConverterState> {
  ImageConverterBloc() : super(ImageInitial()) {
    on<ResetConverter>((event, emit) => emit(ImageInitial()));

    on<ConvertImage>((event, emit) async {
      emit(ImageLoading());
      try {
        // compute() spawns an isolate and runs the worker function
        final result = await compute(
          _compressWorker,
          CompressionParams(event.bytes, event.targetKB, event.format),
        );
        emit(result);
      } catch (e) {
        emit(ImageError("Optimization failed. Try JPEG or PNG."));
      }
    });
  }
}

// Background Worker Function
Future<ImageConverted> _compressWorker(CompressionParams params) async {
  int quality = 95;
  Uint8List compressedData = params.bytes;

  // Browsers don't support HEIC encoding, fallback to JPEG
  CompressFormat targetFormat = (kIsWeb && params.format == CompressFormat.heic)
      ? CompressFormat.jpeg
      : params.format;

  while (quality > 10) {
    final result = await FlutterImageCompress.compressWithList(
      params.bytes,
      quality: quality,
      format: targetFormat,
    );

    compressedData = result;
    if (compressedData.lengthInBytes <= params.targetKB * 1024) break;
    quality -= 15;
  }

  final bool usedOriginal =
      compressedData.lengthInBytes >= params.bytes.lengthInBytes;
  final finalBytes = usedOriginal ? params.bytes : compressedData;

  return ImageConverted(
    finalBytes,
    originalSize: params.bytes.lengthInBytes,
    compressedSize: finalBytes.lengthInBytes,
    format: usedOriginal ? CompressFormat.jpeg : targetFormat,
  );
}
