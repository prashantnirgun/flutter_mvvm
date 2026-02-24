/// Remote data source: performs the HTTP call to `users/user-exists`.
/// Keep HTTP client usage here (inject a client in real implementation).
abstract class UserRemoteDataSource {
  /// Calls `GET users/user-exists?[column]=[value]` and returns `true`
  /// when the resource exists on server, otherwise `false`.
  /// Example: `checkUserExists('email', 'a@b.com')`.
  Future<bool> checkUserExists(String columnName, String value);

  /// Calls registration endpoint and returns the raw API response (usually a
  /// Map with `status` and `data`). Repository may adapt this response as
  /// needed (save token, map to models, etc.).
  Future<dynamic> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String mobile,
    required String password,
  });

  Future<dynamic> loginUser({required String email, required String password});
}
