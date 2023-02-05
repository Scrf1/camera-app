import 'package:camera/camera.dart';
import 'package:camera_app/camera.dart';
import 'package:camera_app/data/global_vars.dart';
import 'package:camera_app/services/file_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cameras = await availableCameras();

  runApp(MyApp(first: cameras.first, second: cameras.last));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.first, required this.second});

  CameraDescription first;
  CameraDescription second;
  String imageFolderPath = '';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    doesFolderExist(appFolderImagesName).then((value) {
      if(value == null) {
        createFolder(appFolderImagesName).then((value) => imageFolderPath = value);
      }
      else {
        imageFolderPath = value;
      }
    });


    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraPage(first, second, imageFolderPath),
    );
  }
}
