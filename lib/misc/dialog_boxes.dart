import 'package:flutter/material.dart';

class DialogBoxes {

  static AlertDialog createDeleteFileDialog({var yesFn, var noFn}) {
      return AlertDialog(
        content: const Text("Are you sure you want to delete this file?"),
        actions: [
          TextButton(
              onPressed: yesFn,
              child: const Text("Yes")
          ),
          TextButton(
              onPressed: noFn,
              child: const Text("No")
          )
        ],
      );
  }

}