import 'package:camera_app/misc/dialog_boxes.dart';
import 'package:camera_app/services/file_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'data/global_vars.dart';

class PhotoEditPage extends StatefulWidget {
  String filePath;

  PhotoEditPage(this.filePath, {super.key});

  @override
  State<StatefulWidget> createState() => _PhotoEditPageState();

}

class _PhotoEditPageState extends State<PhotoEditPage> {

  late AlertDialog deleteFileDialog;
  bool deleteFile = false;
  late File image;

  @override
  void initState() {
    super.initState();

    image = new File(widget.filePath);

    deleteFileDialog = DialogBoxes.createDeleteFileDialog(
      noFn: ()  {
        Navigator.pop(context);
      },
      yesFn: () {
        deleteFile = true;
        Navigator.pop(context);
      }
    );
  }



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
                child: Image.file(image),
              ),
            )

          ],
        ),
      ),
    );
  }

  void onDeleteClicked() {
    showDialog(
        context: context,
        builder: (context) => deleteFileDialog
    )
        .then((value) {
          if(deleteFile) {
            Navigator.pop(context);
          }
    });
  }

  Future<void> onSaveClicked() async {
    saveFile(image, appFolderImagesName).then(
            (value) {
              const snackBar =  SnackBar(
                content:  Text('image saved!')
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            }
    );
  }

}