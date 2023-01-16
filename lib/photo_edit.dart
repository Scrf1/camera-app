import 'package:flutter/material.dart';
import 'dart:io';

class PhotoEditPage extends StatefulWidget {
  String imagePath;

  PhotoEditPage(this.imagePath, {super.key});

  @override
  State<StatefulWidget> createState() => _PhotoEditPageState();

}

class _PhotoEditPageState extends State<PhotoEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          InkWell(
            child: Icon(Icons.save, color: Colors.white,),
            onTap: onSaveClicked,
          ),
          const SizedBox(width: 20,),
          InkWell(
            child: Icon(Icons.delete, color: Colors.white),
            onTap: onDeleteClicked,
          ),
          const SizedBox(width: 20,)
        ],
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: Container(
                child: Image.file(File(widget.imagePath)),
              ),
            )

          ],
        ),
      ),
    );
  }

  void onDeleteClicked() {

  }

  void onSaveClicked() {

  }

}