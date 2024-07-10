import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:math_ai_project/components/loadings.dart';
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
          onTap: () {},
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
