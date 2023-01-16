import 'package:camera/camera.dart';
import 'package:camera_app/photo_edit.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class CameraPage extends StatefulWidget {
  CameraDescription first;
  CameraDescription second;

  CameraPage(this.first, this.second);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _camController;
  late CameraController _frontCamController;
  late CameraController _backCamController;
  late Future<void> _initializeControllerFuture;

  Icon flashIcon = const Icon(Icons.flash_on, color: Colors.white,size: 24,);
  bool isFlashOn = false;
  Icon timerOn = const Icon(Icons.timer, color: Colors.white,size: 24);
  bool isTimerOn = false;
  Icon rotationIcon = const Icon(Icons.camera_front, color: Colors.white,size: 24);
  bool isFrontCamUsed = false;

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
                  CircleAvatar(radius: 25, backgroundColor: Colors.white,),
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
    flashLight().then(
            (value) => _camController.takePicture().then(
                    (image) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhotoEditPage(image!.path))
                )
            )
    );
  }

  Future<void> flashLight() async {
    if(isFlashOn) {
      TorchLight.enableTorch();
    }
    else {
      TorchLight.disableTorch();
    }
  }

  void toggleFlashLight() {
    setState(() {
      if(isFlashOn) {
        flashIcon = const Icon(Icons.flash_off, color: Colors.white,size: 24,);
      }
      else {
        flashIcon = const Icon(Icons.flash_on, color: Colors.white,size: 24,);
      }
      isFlashOn = !isFlashOn;
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
