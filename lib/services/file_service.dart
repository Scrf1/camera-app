import 'dart:io';

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
  print("IN LIST FILES >>>>>>>>>>>>>>>>>>>>>>>");
  if(await dir.exists()) {
    print("DIR EXISTS>>>>>>>>>>>>>>>>>>>>>>>");
    List<FileSystemEntity> entities = dir.listSync();
    Iterable<File> files = entities.whereType<File>();
    return files;
  }
  else {
    return Future.value(null);
  }
}