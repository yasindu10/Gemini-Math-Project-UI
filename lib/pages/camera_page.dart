import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:math_ai_project/components/loadings.dart';
import 'package:math_ai_project/constants/constants.dart';
import 'package:math_ai_project/controller/image_controller.dart';
import 'package:math_ai_project/utils/custom_dialogs.dart';

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
  void takePicture(size) async {
    try {
      XFile file = await widget.controller.takePicture();
      showLoadingDialog(context: context);

      final result = await cropImage(file.path, context);
      Navigator.pop(context);

      showCustomBottomSheet(
        file: file,
        size: size,
        context: context,
        solution: result.toString(),
      );
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
        SafeArea(
          ////// left button
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              const Gap(25),
            ],
          ),
        ),
        Column(
          ////// camera button
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  takePicture(size);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: bgColor,
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
      ],
    );
  }
}
