import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'image_formatter_event.dart';
import 'image_formatter_state.dart';

class FormattingParams {
  final Uint8List bytes;
  final CompressFormat format;
  final String fileName;

  FormattingParams(this.bytes, this.format, this.fileName);
}

class ImageFormatterBloc
    extends Bloc<ImageFormatterEvent, ImageFormatterState> {
  ImageFormatterBloc() : super(FormatterInitial()) {
    on<ResetFormatter>((event, emit) => emit(FormatterInitial()));

    on<FormatImage>((event, emit) async {
      emit(FormatterLoading());
      try {
        final result = await compute(
          _formattingWorker,
          FormattingParams(event.bytes, event.format, event.fileName),
        );
        emit(result);
      } catch (e) {
        emit(FormatterError("Formatting failed. Please try another format."));
      }
    });
  }
}

Future<FormatterSuccess> _formattingWorker(FormattingParams params) async {
  // Web Fallback (Browsers usually can't encode HEIC)
  CompressFormat targetFormat = (kIsWeb && params.format == CompressFormat.heic)
      ? CompressFormat.jpeg
      : params.format;

  // Perform high-quality formatting (90% quality)
  final result = await FlutterImageCompress.compressWithList(
    params.bytes,
    quality: 90,
    format: targetFormat,
  );

  // Dynamic Filename Logic
  final String ext = targetFormat == CompressFormat.jpeg
      ? 'jpg'
      : targetFormat.name.toLowerCase();
  final String baseName = params.fileName.contains('.')
      ? params.fileName.substring(0, params.fileName.lastIndexOf('.'))
      : params.fileName;

  return FormatterSuccess(
    bytes: result,
    originalSize: params.bytes.lengthInBytes,
    formattedSize: result.lengthInBytes,
    format: targetFormat,
    outputFileName: "${baseName}_formatted.$ext",
  );
}
