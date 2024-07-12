import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingWidget() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

void showLoadingDialog({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: LoadingAnimationWidget.halfTriangleDot(
        color:const Color.fromARGB(255, 58, 58, 65),
        size: 70,
      ),
    ),
  );
}
