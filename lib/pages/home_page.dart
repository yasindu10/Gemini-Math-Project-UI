import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.isCameraFound, required this.controller});

  final bool isCameraFound;
  final CameraController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          height: size.height / 2.7,
          width: size.width,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: CameraPreview(widget.controller),
          ),
        ),
        Container(
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Math AI',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
