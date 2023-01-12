import 'package:camera/camera.dart';
import 'package:camera_app/camera.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cameras = await availableCameras();
  runApp(MyApp(first: cameras.first, second: cameras.last,));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.first, required this.second});

  CameraDescription first;
  CameraDescription second;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraPage(first, second),
    );
  }
}
