import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoEditPage extends StatefulWidget {
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

      ),
    );
  }

  void onDeleteClicked() {

  }

  void onSaveClicked() {

  }

}