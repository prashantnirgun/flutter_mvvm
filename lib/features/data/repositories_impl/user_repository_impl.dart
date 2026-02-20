import 'package:bpp/core/constants/app_urls.dart';
import 'package:bpp/core/network/api_helper.dart';
import 'package:bpp/core/constants/app_constant.dart';
import 'package:bpp/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiHelper apiHelper;
  final AuthLocalDataSource authLocalDataSource;

  UserRepositoryImpl({
    required this.apiHelper,
    required this.authLocalDataSource,
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
      return await apiHelper.postApi(
        url: AppUrls.registrationUrl,
        mBodyParams: {
          "email": email,
          "full_name": fullName,
          "user_name": userName,
          "mobile": mobile,
          "password": password,
          "email_verified": "No",
          "user_status": "Active",
        },
        isAuth: true,
      );
    } catch (e) {
      rethrow;
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

        try {
          if (token.isNotEmpty) {
            await authLocalDataSource.saveToken(token);
          }
          if (data.isNotEmpty) {
            await authLocalDataSource.saveUser(data);
          }
        } catch (_) {}
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
  Future<bool> userExists(String userName) async {
    try {
      final url = "${AppUrls.userExistsUrl}?user_name=$userName";
      final response = await apiHelper.getApi(url: url);

      // Expected shapes (be defensive):
      // 1) { "exists": true }
      // 2) { "status": "success", "data": { "exists": true } }
      // 3) boolean `true`/`false`
      if (response is bool) return response;
      if (response is Map) {
        if (response.containsKey('exists')) {
          return response['exists'] == true;
        }
        if (response['status'] == 'success' && response['data'] is Map) {
          final data = Map<String, dynamic>.from(response['data']);
          if (data.containsKey('exists')) return data['exists'] == true;
        }
      }

      // Unknown response format — default to `false` (available)
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
