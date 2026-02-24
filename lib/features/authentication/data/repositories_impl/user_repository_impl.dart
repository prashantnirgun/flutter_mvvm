import 'package:bpp/core/constants/app_urls.dart';
import 'package:bpp/core/network/api_helper.dart';
import 'package:bpp/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:bpp/features/authentication/data/datasources/user_remote_data_source.dart';
import 'package:bpp/features/authentication/data/models/user_model.dart';
import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiHelper apiHelper;
  final AuthLocalDataSource? authLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({
    required this.apiHelper,
    this.authLocalDataSource,
    required this.userRemoteDataSource,
  });

  @override
  Future<dynamic> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      // Delegate HTTP call to data source.
      final response = await userRemoteDataSource.registerUser(
        fullName: fullName,
        userName: userName,
        email: email,
        mobile: mobile,
        password: password,
      );

      return response;
    } catch (e, st) {
      // Return a consistent failure Map so callers (Blocs/usecases)
      // can handle errors without requiring try/catch.
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
      dynamic response = await userRemoteDataSource.loginUser(
        email: email,
        password: password,
      );
      // Persist token/user using local datasource when available.
      if (response is Map && response['status'] == 'success') {
        final data = response['data'] != null && response['data'] is Map
            ? Map<String, dynamic>.from(response['data'])
            : <String, dynamic>{};

        // Persist token/user using local datasource when available.
        final token = (data['jwt_token'] ?? '').toString();

        //remove unwanted fields from response
        Map<String, dynamic> sanitizeUserJson(Map<String, dynamic> json) {
          final copy = Map<String, dynamic>.from(json);
          copy.remove('password');
          copy.remove('jwt_token');
          return copy;
        }

        final userData = sanitizeUserJson(data);
        try {
          if (authLocalDataSource != null) {
            if (token.isNotEmpty) {
              await authLocalDataSource!.saveToken(token);
            }
            if (data.isNotEmpty) {
              await authLocalDataSource!.saveUser(sanitizeUserJson(userData));
            }
          }
        } catch (_) {}

        // Convert response data to domain model and return it.
        final user = UserModel.fromJson(userData);
        return user;
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> logoutUser() async {
    try {
      //clear session
      await authLocalDataSource?.clear();

      // Persist token/user using local datasource when available.
      //return boolean response

      return true;
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
    if (authLocalDataSource == null) return null;
    try {
      return await authLocalDataSource!.getUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> userExists(String columnName, String value) async {
    try {
      return await userRemoteDataSource.checkUserExists(columnName, value);
    } catch (e) {
      rethrow;
    }
  }
}
