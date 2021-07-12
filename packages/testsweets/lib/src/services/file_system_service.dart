import 'dart:io';

abstract class FileSystemService {
  bool doesFileExist(String path);

  String readFileAsStringSync(String path);

  Stream<List<int>> openFileForReading(String path);

  int getFileSizeInBytes(String path);

  String get fullPathToWorkingDirectory;
}

class FileSystemServiceImplementation implements FileSystemService {
  bool doesFileExist(String path) {
    return File(path).existsSync();
  }

  String readFileAsStringSync(String path) {
    return File(path).readAsStringSync();
  }

  int getFileSizeInBytes(String path) {
    return File(path).lengthSync();
  }

  Stream<List<int>> openFileForReading(String path) {
    return File(path).openRead();
  }

  String fullPathToWorkingDirectory = Directory.current.path;
}
