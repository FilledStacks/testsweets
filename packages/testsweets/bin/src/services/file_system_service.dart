import 'dart:io';

import 'dart:typed_data';

abstract class FileSystemService {
  bool doesFileExist(String path);

  String readFileAsStringSync(String path);

  Uint8List readFileAsBytesSync(String path);

  String get fullPathToWorkingDirectory;

  factory FileSystemService.makeInstance() {
    return _FileSystemService();
  }
}

class _FileSystemService implements FileSystemService {
  bool doesFileExist(String path) {
    return File(path).existsSync();
  }

  String readFileAsStringSync(String path) {
    return File(path).readAsStringSync();
  }

  Uint8List readFileAsBytesSync(String path) {
    return File(path).readAsBytesSync();
  }

  String fullPathToWorkingDirectory = Directory.current.path;
}
