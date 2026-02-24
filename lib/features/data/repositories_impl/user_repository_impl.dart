import '../../../core/constants/app_urls.dart';
import '../../../core/network/api_helper.dart';
import '../../../core/constants/app_constant.dart';
import '../../authentication/data/datasources/auth_local_data_source.dart';
import '../../authentication/data/datasources/user_remote_data_source.dart';
import '../../authentication/data/models/user_model.dart';
import '../../authentication/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiHelper apiHelper;
  final AuthLocalDataSource authLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({
    required this.apiHelper,
    required this.authLocalDataSource,
    required this.userRemoteDataSource,
  });

  @override
  Future<bool> logoutUser() async {
    await authLocalDataSource.clear();
    return true;
  }

  @override
  Future<dynamic> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await userRemoteDataSource.registerUser(
        fullName: fullName,
        userName: userName,
        email: email,
        mobile: mobile,
        password: password,
      );

      return response;
    } catch (e, st) {
      return {
        'status': 'error',
        'message': e.toString(),
        'stack': st.toString(),
      };
    }
  }

  @override
  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      dynamic response = await apiHelper.postApi(
        url: AppUrls.loginUrl,
        mBodyParams: {
          "email": email,
          "password": password,
          "secretkey": AppConstants.API_KEY,
        },
        isAuth: true,
      );
      // If success, persist token and user data to local datasource
      if (response is Map && response['status'] == 'success') {
        final data = response['data'] != null && response['data'] is Map
            ? Map<String, dynamic>.from(response['data'])
            : <String, dynamic>{};

        final token = (data['jwt_token'] ?? data['token'] ?? '').toString();

        // remove sensitive fields before persisting
        final sanitized = Map<String, dynamic>.from(data);
        sanitized.remove('password');
        sanitized.remove('jwt_token');

        try {
          if (token.isNotEmpty) {
            await authLocalDataSource.saveToken(token);
          }
          if (sanitized.isNotEmpty) {
            await authLocalDataSource.saveUser(sanitized);
          }
        } catch (_) {}

        // convert to model and return
        final user = UserModel.fromJson(sanitized);
        return user;
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fetchUsers() async {
    try {
      return await apiHelper.getApi(url: AppUrls.userListUrl);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getSavedUser() async {
    try {
      return await authLocalDataSource.getUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> userExists(String columnName, String value) async {
    try {
      final exists = await userRemoteDataSource.checkUserExists(
        columnName,
        value,
      );
      return exists;
    } catch (e) {
      rethrow;
    }
  }
}
