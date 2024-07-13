import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:math_ai_project/constants/constants.dart';

Widget loadingWidget() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

void showLoading({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: LoadingAnimationWidget.halfTriangleDot(
        color: bgColor,
        size: 70,
      ),
    ),
  );
}
