import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

/// UseCase: Register User
///
/// Delegates registration requests to the repository and represents the
/// registration operation in the domain layer. Keeps presentation code free
/// from networking/persistence details.
class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  Future<dynamic> call({
    required String fullName,
    required String userName,
    required String email,
    required String mobile,
    required String password,
  }) async {
    return await repository.registerUser(
      fullName: fullName,
      userName: userName,
      email: email,
      mobile: mobile,
      password: password,
    );
  }
}
