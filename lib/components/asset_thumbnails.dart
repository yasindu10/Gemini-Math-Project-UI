import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:math_ai_project/utils/loadings.dart';
import 'package:math_ai_project/controller/image_controller.dart';
import 'package:math_ai_project/utils/custom_dialogs.dart';
import 'package:math_ai_project/utils/messages.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    super.key,
    required this.asset,
  });

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<Uint8List>(
      future: asset.thumbnailData.then((value) => value!),
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) return loadingWidget();
        return InkWell(
          onTap: () async {
            File? file = await asset.file;

            if (file != null) {
              showLoading(context: context); // start the loading

              final result = await cropImage(file.path, context);
              Navigator.pop(context); // stop the loading

              if (result == null) {
                return showErrorMessage(context, 'Error, try again');
              } else if (result == 'cancel') {
                return showMessage(context, 'Closed');
              }

              showResultDialog(
                file: XFile(file.path),
                size: size,
                context: context,
                solution: result.toString(),
              );
            } else {
              showErrorMessage(context, 'Error, file is not found');
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // Adjust the value as needed
                  child: Image.memory(bytes, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
