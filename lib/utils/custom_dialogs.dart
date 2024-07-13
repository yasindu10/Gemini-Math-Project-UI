import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:math_ai_project/constants/constants.dart';

void showResultDialog({
  required BuildContext context,
  required Size size,
  required String solution,
  required XFile file,
}) {
  final exampleFile = File(file.path);
  showModalBottomSheet(
    backgroundColor: bgColor,
    isScrollControlled: true,
    context: context,
    useSafeArea: true,
    builder: (context) => Container(
      width: size.width,
      height: size.height / 1.2,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.black12,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            child: const Text(
              'Problem',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: size.width, // Assuming size is defined somewhere
            decoration: BoxDecoration(
              color: const Color.fromARGB(41, 14, 14, 14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
              child: Image.file(
                exampleFile,
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            child: const Text(
              'Solution',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          const Gap(10),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(41, 14, 14, 14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    solution,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.copy_rounded,
                          size: 19,
                        ),
                      ),
                      const Gap(12),
                      GestureDetector(
                        child: const Icon(
                          Icons.thumb_down_alt_outlined,
                          size: 19,
                        ),
                      ),
                    ],
                  )
                ],
              )),
          const Gap(20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MathLens can make mistakes. Check image quality.',
                style: TextStyle(fontSize: 13),
              )
            ],
          )
        ],
      ),
    ),
  );
}
