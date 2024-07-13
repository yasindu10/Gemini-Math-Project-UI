import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:math_ai_project/components/loadings.dart';
import 'package:math_ai_project/constants/constants.dart';
import 'package:math_ai_project/controller/image_controller.dart';
import 'package:math_ai_project/utils/error_messages.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    super.key,
    required this.asset,
  });

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: asset.thumbnailData.then((value) => value!),
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) return loadingWidget();
        return InkWell(
          onTap: () async {
            File? file = await asset.file;

            if (file != null) {
              cropImage(file.path, context);
            } else {
              showMessage(context, 'Error, file is not found');
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
