import 'package:bpp/core/constants/app_constant.dart';
import 'package:bpp/core/constants/app_urls.dart';
import 'package:bpp/core/network/api_helper.dart';
import 'package:bpp/features/authentication/data/datasources/user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiHelper apiHelper;

  UserRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<bool> checkUserExists(String columnName, String value) async {
    final encoded = Uri.encodeComponent(value);
    final url = "${AppUrls.userExistsUrl}?$columnName=$encoded";
    final response = await apiHelper.getApi(url: url);

    if (response is Map<String, dynamic>) {
      return response['status'] == 'success';
    }

    return false;
  }

  @override
  Future<dynamic> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String mobile,
    required String password,
  }) async {
    final url = AppUrls.registrationUrl;
    try {
      final response = await apiHelper.postApi(
        url: url,
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

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future loginUser({required String email, required String password}) async {
    final url = AppUrls.loginUrl;
    try {
      final response = await apiHelper.postApi(
        url: url,
        mBodyParams: {
          "email": email,
          "password": password,
          "secretkey": AppConstants.API_KEY,
        },
        isAuth: true,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
