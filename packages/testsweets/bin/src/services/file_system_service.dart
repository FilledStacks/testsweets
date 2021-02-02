import 'dart:io';

abstract class FileSystemService {
  bool doesFileExist(String path);

  String readFileAsStringSync(String path);

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

  String fullPathToWorkingDirectory = Directory.current.path;
}
