import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

/// UseCase: Fetch Users
///
/// Retrieves a list of users (or server-side users) via the repository.
/// The domain layer expresses the operation but delegates data retrieval to
/// the repository implementation.
class FetchUsersUseCase {
  final UserRepository repository;

  FetchUsersUseCase(this.repository);

  Future<dynamic> call() async {
    return await repository.fetchUsers();
  }
}
