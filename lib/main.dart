import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_ai_project/constants/constants.dart';
import 'package:math_ai_project/pages/camera_page.dart';
import 'package:math_ai_project/pages/home_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late CameraController controller;

  // List<CameraDescription>? cameras;

  // Future<void> getCameras() async {
  // //   cameras = await availableCameras();

  // //   controller = CameraController(cameras![0], ResolutionPreset.max);
  // //   controller.initialize().then((_) {
  // //     if (!mounted) {
  // //       return;
  // //     }
  // //     setState(() {});
  // //   }).catchError((Object e) {
  // //     if (e is CameraException) {
  // //       switch (e.code) {
  // //         case 'CameraAccessDenied':
  // //           break;
  // //         default:
  // //           break;
  // //       }
  // //     }
  // //     setState(() {});
  // //   });
  // // }

  // // @override
  // // void initState() {
  // //   super.initState();
  // //   getCameras();
  // // }

  // // @override
  // // void dispose() {
  // //   controller.dispose();
  // //   super.dispose();
  // // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      // home: cameras == null
      //     // loading the cameras
      //     ? const Center(
      //         child: CircularProgressIndicator(
      //           color: Colors.blueAccent,
      //         ),
      //       )
      //     : HomePage(
      //         isCameraFound: controller.value.isInitialized,
      //         controller: controller,
      //       ),
      home: HomePage(isCameraFound: false, controller: null),
    );
  }
}
