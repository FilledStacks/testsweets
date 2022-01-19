import 'dart:io';

abstract class FileSystemService {
  bool doesFileExist(String path);

  String readFileAsStringSync(String path);

  Stream<List<int>> openFileForReading(String path);

  int getFileSizeInBytes(String path);

  String fullPathToWorkingDirectory({String? fileName});
}

class FileSystemServiceImplementation implements FileSystemService {
  @override
  bool doesFileExist(String path) {
    return File(path).existsSync();
  }

  @override
  String readFileAsStringSync(String path) {
    return File(path).readAsStringSync();
  }

  @override
  int getFileSizeInBytes(String path) {
    return File(path).lengthSync();
  }

  @override
  Stream<List<int>> openFileForReading(String path) {
    return File(path).openRead();
  }

  @override
  String fullPathToWorkingDirectory({String? fileName}) {
    /// If you running on mac or linux
    /// use forward slash instead of backslash
    final seperator = !Platform.isWindows ? '\/' : '\\';

    return Directory.current.path +
        (fileName != null ? seperator + fileName : '');
  }
}
