import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:developer' as console;

Future<String> cropImage(String imagePath, BuildContext context) async {
  try {
    File? imageFile;

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
      imageFile = File(croppedFile.path);
      return await uploadImage(imageFile);
    }

    return 'canceled';
  } catch (err) {
    return 'Error with $err';
  }
}

Future<String> uploadImage(File? imageFile) async {
  String uploadUrl =
      'https://gemini-math-project-production.up.railway.app/api/v1/ai/';

  var request = http.MultipartRequest('GET', Uri.parse(uploadUrl));
  request.files
      .add(await http.MultipartFile.fromPath('image', imageFile!.path));

  var response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(respStr);
    console.log(jsonResponse['data'].toString());
    return jsonResponse['data'].toString();
  } else {
    return 'error';
  }
}
