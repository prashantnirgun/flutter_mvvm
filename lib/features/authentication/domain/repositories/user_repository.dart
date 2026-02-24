/// Domain layer: repository interface
/// Keep this file free of platform or framework dependencies.
abstract class UserRepository {
  /// Returns `true` if the value for [columnName] already exists on the server.
  ///
  /// Example: `userExists('email', 'foo@bar.com')` or
  /// `userExists('user_name', 'alice')`.
  /// Implementations should translate data-layer errors into domain-level
  /// failures according to the project's error handling (Either/Failure or
  /// exceptions).
  Future<bool> userExists(String columnName, String value);

  Future<dynamic> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String mobile,
    required String password,
  });

  Future<dynamic> loginUser({required String email, required String password});
  Future<bool> logoutUser();

  Future<dynamic> fetchUsers();

  /// Returns saved user JSON from local storage if available.
  ///
  /// The returned value is a `Map<String, dynamic>` representation of the
  /// user data (matching `UserModel.fromJson`), or `null` when no user is
  /// saved. This abstraction keeps persistence details out of the domain
  /// layer — implementations may source this from `SharedPreferences` or
  /// secure storage.
  Future<Map<String, dynamic>?> getSavedUser();
}
