import 'dart:io';

import 'package:camera_app/data/global_vars.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> createFolder(String folderName) async {
  final dir = Directory((Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!
          .path + '/$folderName');
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await dir.exists())) {
    return dir.path;
  } else {
    dir.create();
    return dir.path;
  }
}

Future<String?> doesFolderExist(String folderName) async {
    final dir = Directory(
        (Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!
        .path + '/$folderName');
   if(await dir.exists()) {
     return dir.path;
   }
   else {
     return null;
   }
}

Future<Iterable<File>> listFilesOfDirectory(String directoryPath) async {
  final dir = Directory(directoryPath);
  if(await dir.exists()) {
    List<FileSystemEntity> entities = dir.listSync();
    Iterable<File> files = entities.whereType<File>();
    return files;
  }
  else {
    return Future.value(null);
  }
}

Future<String> saveFile(File toSave, String directoryName) async {
  DateTime d = DateTime.now();
  doesFolderExist(directoryName).then((value) async {
    File file = await toSave.copy("$value/IMG_${d.year}${d.month}${d.day}_${d.hour}${d.minute}${d.second}.png");
    return file.path;
  });
  return "";

}
