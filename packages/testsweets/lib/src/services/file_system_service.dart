abstract class FileSystemService {
  bool doesFileExist(String path);
  String readFileAsStringSync(String path);

  factory FileSystemService.makeInstance() {
    throw UnimplementedError();
  }
}
