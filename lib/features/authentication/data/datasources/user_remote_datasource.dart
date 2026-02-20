import '../../data/models/user_exists_model.dart';

/// Remote data source: performs the HTTP call to `users/user-exists`.
/// Keep HTTP client usage here (inject a client in real implementation).
abstract class UserRemoteDataSource {
  /// Calls `GET users/user-exists?user_name=...` and returns a model.
  Future<UserExistsModel> checkUserExists(String userName);
}
