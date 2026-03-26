import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../bloc/image_converter_bloc.dart';
import '../bloc/image_converter_event.dart';
import '../bloc/image_converter_state.dart';

class ImageConverterScreen extends StatelessWidget {
  const ImageConverterScreen({super.key});

  Future<void> pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      context.read<ImageConverterBloc>().add(
        ConvertImage(result.files.first.bytes!),
      );
    }
  }

  void download(Uint8List bytes) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "image.png")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageConverterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Image Converter")),
        body: Center(
          child: BlocBuilder<ImageConverterBloc, ImageConverterState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => pickFile(context),
                    child: const Text("Upload Image"),
                  ),
                  const SizedBox(height: 20),
                  if (state is ImageConverted)
                    ElevatedButton(
                      onPressed: () => download(state.bytes),
                      child: const Text("Download PNG"),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}