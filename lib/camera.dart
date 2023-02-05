import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/data/flash_light_status.dart';
import 'package:camera_app/photo_edit.dart';
import 'package:flutter/material.dart';
import 'package:camera_app/services/file_service.dart';
import 'package:path/path.dart' as path;

class CameraPage extends StatefulWidget {
  CameraDescription first;
  CameraDescription second;
  String imageFolderPath;

  CameraPage(this.first, this.second, this.imageFolderPath);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _camController;
  late CameraController _frontCamController;
  late CameraController _backCamController;
  late Future<void> _initializeControllerFuture;

  Icon flashIcon = const Icon(Icons.flash_off, color: Colors.white,size: 24,);
  int flashIconIdx = 0;
  Icon timerOn = const Icon(Icons.timer, color: Colors.white,size: 24);
  bool isTimerOn = false;
  Icon rotationIcon = const Icon(Icons.camera_front, color: Colors.white,size: 24);
  bool isFrontCamUsed = false;
  //late Widget galleryImgAvatar;

  late Future<File> lastTakenPicture;

  @override
  void initState() {
    super.initState();
    _backCamController = CameraController(
      widget.first,
      ResolutionPreset.max,
    );
    _frontCamController = CameraController(
        widget.second,
        ResolutionPreset.max);

    _camController = _backCamController;
    _initializeControllerFuture = _camController.initialize();
    /*listFilesOfDirectory(widget.imageFolderPath).then((files) {
      if(files.length > 0) {
        for(File file in files) {
          if(['jpg', 'png', 'gif', 'tiff', 'jpeg'].contains(path.extension(file.path).toLowerCase())) {
            galleryImgAvatar = Image.file(file);
            break;
          }
        }
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_camController);
                  }
                  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
          ),

          Positioned(
            top: 40,
            width: MediaQuery.of(context).size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: Icon(Icons.settings, color: Colors.white,size: 24,),
                      onPressed: null
                  ),
                  IconButton(
                      icon: flashIcon,
                      onPressed: toggleFlashLight
                  ),
                  IconButton(
                    icon: timerOn,
                    onPressed: toggleTimer,
                  ),
                  IconButton(
                      icon: rotationIcon,
                      onPressed: toggleFrontOrRearCamera
                  )
                ],
              ),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FutureBuilder<void>(builder: (context, snapshot) =>
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        //child: galleryImgAvatar,
                      )
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: FittedBox(
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt, color: Colors.black),
                          onPressed: takePicture
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FittedBox(
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.video_call, color: Colors.black),
                          onPressed: null
                      ),
                    ),
                  ),
                ],
              ),
          )
        ],
      )
      ,
    );
  }

  void takePicture() {
     _camController.takePicture().then(
             (image) => Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => PhotoEditPage(image!.path))
             )
    );
  }

  void toggleFlashLight() {
    setState(() {

      flashIconIdx = (flashIconIdx + 1) % 3;

      if(FlashLightStatus.values[flashIconIdx] == FlashLightStatus.none) {
        flashIcon = const Icon(Icons.flash_off, color: Colors.white,size: 24,);
        _camController.setFlashMode(FlashMode.off);
      }
      else if(FlashLightStatus.values[flashIconIdx] == FlashLightStatus.auto) {
        flashIcon = const Icon(Icons.flash_auto, color: Colors.white,size: 24,);
        _camController.setFlashMode(FlashMode.auto);
      }
      else if(FlashLightStatus.values[flashIconIdx] == FlashLightStatus.enabled) {
        flashIcon = const Icon(Icons.flash_on, color: Colors.white,size: 24,);
        _camController.setFlashMode(FlashMode.torch);
      }
    });
  }

  void toggleTimer() {
    setState(() {
    });
  }

  void toggleFrontOrRearCamera()  {
    setState(() {
      if(isFrontCamUsed) {
        rotationIcon = const Icon(Icons.camera_rear, color: Colors.white,size: 24);
        _camController = _frontCamController;
      }
      else {
        rotationIcon = const Icon(Icons.camera_front, color: Colors.white,size: 24);
        _camController = _backCamController;
      }
      isFrontCamUsed = !isFrontCamUsed;

      _initializeControllerFuture =  _camController.initialize();
    });
  }

  @override
  void dispose() {
    _camController.dispose();
    super.dispose();
  }
}
