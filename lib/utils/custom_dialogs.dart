import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showCustomBottomSheet(context, Size size, String solution) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.black12,
      ),
      child: ListView(
        children: [
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
              color: const Color.fromARGB(106, 14, 14, 14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              solution,
              style: const TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    ),
  );
}
