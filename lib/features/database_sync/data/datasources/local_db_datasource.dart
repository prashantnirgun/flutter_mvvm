import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class LocalDbDataSource {
  Future<String> getDbPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return join(dir.path, "app_database.db");
  }

  Future<File> prepareDbFile() async {
    final path = await getDbPath();
    final file = File(path);

    if (await file.exists()) {
      await file.delete();
    }

    return file;
  }
}
