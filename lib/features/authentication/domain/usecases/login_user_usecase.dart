import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

/// UseCase: Login User
///
/// This domain usecase coordinates the login action. It delegates the actual
/// work to the `UserRepository`, keeping business logic separate from data
/// and presentation layers. The repository is responsible for networking and
/// persistence; the usecase focuses on expressing the operation in the domain
/// layer.
class LoginUserUseCase {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  /// Executes the login flow with the provided [email] and [password].
  ///
  /// Returns whatever the repository returns (typically a parsed response
  /// map containing status and data). Callers (e.g., Blocs) should interpret
  /// the result and update UI/state accordingly.
  Future<dynamic> call({
    required String email,
    required String password,
  }) async {
    return await repository.loginUser(email: email, password: password);
  }
}
