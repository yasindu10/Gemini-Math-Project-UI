import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:math_ai_project/components/bottom_navigation.dart';
import 'package:math_ai_project/pages/dashboard_page.dart';
import 'package:math_ai_project/pages/home_page.dart';

class CustomPageController extends StatefulWidget {
  const CustomPageController({
    super.key,
    required this.isCameraFound,
    required this.controller,
  });

  final bool isCameraFound;
  final CameraController controller;

  @override
  State<CustomPageController> createState() => _CustomPageControllerState();
}

class _CustomPageControllerState extends State<CustomPageController> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // initialize the pages
    List<Widget> _pages = [
      HomePage(
        controller: widget.controller,
        isCameraFound: widget.isCameraFound,
      ),
      const Dashboard(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Math Lens'),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 17),
            child: const CircleAvatar(
              backgroundColor: Colors.black26,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/94032631?v=4'),
            ),
          )
        ],
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: CustomBottomNavbar(
        onChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        selectedIndex: 0,
      ),
    );
  }
}
