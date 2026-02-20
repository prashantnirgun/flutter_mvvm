import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';

class FtpDataSource {
  final String host;
  final String username;
  final String password;

  FtpDataSource({
    required this.host,
    required this.username,
    required this.password,
  });

  Future<bool> downloadFile({
    required String remotePath,
    required File localFile,
  }) async {
    final ftp = FTPConnect(host, user: username, pass: password);

    try {
      await ftp.connect();
      final result = await ftp.downloadFile(remotePath, localFile);
      await ftp.disconnect();
      return result;
    } catch (e) {
      await ftp.disconnect();
      rethrow;
    }
  }
}
