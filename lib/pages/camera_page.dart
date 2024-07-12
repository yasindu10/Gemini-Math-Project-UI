import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:math_ai_project/components/loadings.dart';
import 'package:math_ai_project/constants/constants.dart';
import 'package:math_ai_project/controller/image_controller.dart';
import 'package:math_ai_project/utils/canves_paint.dart';
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
      // showLoadingDialog(context: context); // start the loading

      // final result = await cropImage(file.path, context);
      // Navigator.pop(context); // stop the loading

      showCustomBottomSheet(
        file: file,
        size: size,
        context: context,
        // solution: result.toString(),
        solution: 'the best solution',
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: CameraPreview(widget.controller),
          ),
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: CornerPainter(),
          ),
          SafeArea(
            ////// left button
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(7.5),
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              ////// camera button
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            padding: const EdgeInsets.all(14),
                            child: const Icon(
                              Icons.camera_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
