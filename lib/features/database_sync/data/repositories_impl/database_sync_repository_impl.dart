import '../../domain/repositories/database_sync_repository.dart';
import '../datasources/ftp_datasource.dart';
import '../datasources/local_db_datasource.dart';

class DatabaseSyncRepositoryImpl implements DatabaseSyncRepository {
  final FtpDataSource ftpDataSource;
  final LocalDbDataSource localDbDataSource;

  DatabaseSyncRepositoryImpl({
    required this.ftpDataSource,
    required this.localDbDataSource,
  });

  @override
  Future<void> downloadDatabase() async {
    final file = await localDbDataSource.prepareDbFile();

    final success = await ftpDataSource.downloadFile(
      remotePath: "/remote/path/app_database.db",
      localFile: file,
    );

    if (!success) {
      throw Exception("Database download failed");
    }
  }
}
