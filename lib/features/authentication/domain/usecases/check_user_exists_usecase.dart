import '../repositories/user_repository.dart';

/// UseCase: Check if a username/email exists on server.
class CheckUserExistsUseCase {
  final UserRepository repository;

  CheckUserExistsUseCase(this.repository);

  /// Returns `true` if the given [value] for [columnName] exists on server.
  Future<bool> call(String columnName, String value) async {
    if (columnName.isEmpty || value.isEmpty) return false;
    return await repository.userExists(columnName, value);
  }
}
