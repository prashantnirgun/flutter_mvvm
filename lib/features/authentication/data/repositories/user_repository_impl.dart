import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

import '../datasources/user_remote_datasource.dart';

/// Repository implementation: adapts the remote datasource to the domain interface.
abstract class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> userExists(String userName) async {
    // Implementation should call remoteDataSource.checkUserExists and
    // map the result to a `bool`. Error mapping to domain failures should
    // happen here. Left unimplemented as a skeleton.
    throw UnimplementedError();
  }
}
