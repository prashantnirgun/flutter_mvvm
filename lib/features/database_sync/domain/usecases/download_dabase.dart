import '../repositories/database_sync_repository.dart';

class DownloadDatabase {
  final DatabaseSyncRepository repository;

  DownloadDatabase(this.repository);

  Future<void> call() async {
    return await repository.downloadDatabase();
  }
}
