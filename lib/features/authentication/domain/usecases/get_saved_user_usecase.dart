import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

/// UseCase: Get Saved User
///
/// Returns the saved user JSON (if any) from local storage via the
/// [UserRepository]. The domain layer remains storage-agnostic; repository
/// implementations decide how and where the data is persisted.
class GetSavedUserUseCase {
  final UserRepository repository;

  GetSavedUserUseCase(this.repository);

  /// Returns a `Map<String, dynamic>` representing saved user data, or
  /// `null` if no saved user exists.
  Future<Map<String, dynamic>?> call() async {
    return await repository.getSavedUser();
  }
}
