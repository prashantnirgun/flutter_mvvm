import '../repositories/user_repository.dart';

/// UseCase: Check if a username exists.
///
/// This is a domain-level wrapper around `UserRepository.userExists`.
class CheckUserExists {
  final UserRepository repository;

  CheckUserExists(this.repository);

  /// Returns `true` if username exists, `false` if available.
  /// Perform minimal validation here (e.g., non-empty). Implementation omitted.
  Future<bool> call(String userName) async {
    throw UnimplementedError();
  }
}
