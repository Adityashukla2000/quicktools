import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../bloc/image_converter_bloc.dart';
import '../bloc/image_converter_event.dart';
import '../bloc/image_converter_state.dart';

class ImageConverterScreen extends StatefulWidget {
  const ImageConverterScreen({super.key});

  @override
  State<ImageConverterScreen> createState() => _ImageConverterScreenState();
}

class _ImageConverterScreenState extends State<ImageConverterScreen> {
  Uint8List? selectedImage;
  int targetKB = 20;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null) {
      selectedImage = result.files.first.bytes;
      setState(() {});
    }
  }

  void download(Uint8List bytes) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "compressed.jpg")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return BlocProvider(
      create: (_) => ImageConverterBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text("Image Compressor"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: isMobile ? double.infinity : 600,
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<ImageConverterBloc, ImageConverterState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Upload Area
                        GestureDetector(
                          onTap: pickFile,
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: selectedImage == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.upload, size: 40),
                                      SizedBox(height: 10),
                                      Text("Click to Upload Image"),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.memory(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Target Size
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Target Size (KB)"),
                            DropdownButton<int>(
                              value: targetKB,
                              items: [20, 50, 100, 200]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text("$e KB"),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                setState(() {
                                  targetKB = v!;
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// Compress Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: selectedImage == null
                              ? null
                              : () {
                                  context.read<ImageConverterBloc>().add(
                                    ConvertImage(selectedImage!, targetKB),
                                  );
                                },
                          child: const Text("Compress Image"),
                        ),

                        const SizedBox(height: 20),

                        /// Loading
                        if (state is ImageLoading)
                          const CircularProgressIndicator(),

                        /// Result
                        if (state is ImageConverted)
                          Column(
                            children: [
                              Text(
                                "Original: ${(state.originalSize / 1024).toStringAsFixed(2)} KB",
                              ),
                              Text(
                                "Compressed: ${(state.compressedSize / 1024).toStringAsFixed(2)} KB",
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () => download(state.bytes),
                                icon: const Icon(Icons.download),
                                label: const Text("Download"),
                              ),
                            ],
                          ),

                        if (state is ImageError)
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
