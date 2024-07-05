import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: 100,
              child: CameraPreview(widget.controller),
            ),
          ),
        ),
        const Gap(20),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(50, 0, 0, 0),
              shape: BoxShape.circle,
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.camera_rear,
                  color: Colors.white,
                  size: 30,
                )),
          ),
        )
      ],
    );
  }
}
