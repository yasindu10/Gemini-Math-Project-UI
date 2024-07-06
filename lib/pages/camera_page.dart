import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:developer' as console;

class CameraPage extends StatefulWidget {
  const CameraPage({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;

  Future<void> _cropImage(String imagePath) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black87,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _imageFile = File(croppedFile.path);
        });
      }

      console.log('calling');

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(_imageFile!.path,
            filename: 'example.jpg'),
      });

      Dio dio = Dio();

      var response = await dio.get(
        'https://gemini-math-project-production.up.railway.app/api/v1/ai',
        data: formData,
      );

      console.log(response.data);
    } catch (err) {
      console.log('Error with ' + err.toString());
    }
  }

  void takePicture() async {
    try {
      final XFile file = await widget.controller.takePicture();
      // Use the file.path to do something with the captured image.
      print('Picture saved to ${file.path}');
      _cropImage(file.path);
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: size.height,
          width: size.width,
          child: CameraPreview(widget.controller),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  takePicture();
                  // showCustomBottomSheet(context, size);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(50, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Icon(
                    Icons.camera_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            const Gap(25),
          ],
        ),
        // Positioned(
        //   bottom: 0,
        //   child: Container(
        //     width: size.width,
        //     height: 100,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //     ),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text('Solution'),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
