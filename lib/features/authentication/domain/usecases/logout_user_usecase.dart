import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

/// UseCase: Login User
///
/// This domain usecase coordinates the login action. It delegates the actual
/// work to the `UserRepository`, keeping business logic separate from data
/// and presentation layers. The repository is responsible for networking and
/// persistence; the usecase focuses on expressing the operation in the domain
/// layer.
class LogoutUserUseCase {
  final UserRepository repository;

  LogoutUserUseCase(this.repository);

  Future<dynamic> call() async {
    return await repository.logoutUser();
  }
}
