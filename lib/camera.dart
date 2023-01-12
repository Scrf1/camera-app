import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  CameraDescription first;
  CameraDescription second;

  CameraPage(this.first, this.second);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _camController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _camController = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.first,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
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
                  print("Connection state >>>>>> ${snapshot.connectionState}");
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
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.settings, color: Colors.white,size: 24,),
                      onPressed: null)
                ],
              ),
            ),

          )
        ],
      )
      ,
    );
  }

  @override
  void dispose() {}
}
