import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      final XFile file = await widget.controller.takePicture();
      final result = await cropImage(file.path, context);

      showCustomBottomSheet(context, size, result.toString());
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
                onTap: () {},
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
      ],
    );
  }
}
