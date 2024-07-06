import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showCustomBottomSheet(context, Size size) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black12,
      ),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              'Solution',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            width: size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(106, 14, 14, 14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '',
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    ),
  );
}
