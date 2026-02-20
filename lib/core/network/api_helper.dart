import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './app_exception.dart';

class ApiHelper {
  //get
  Future<dynamic> getApi({
    required String url,
    Map<String, String>? mHeaderParams,
  }) async {
    mHeaderParams ??= {};
    /*
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    */
    String token = await getToken();

    mHeaderParams["Authorization"] = "Bearer $token";

    try {
      var response = await http.get(Uri.parse(url), headers: mHeaderParams);
      return returnResponse(response);
      // ignore: unused_catch_clause
    } on SocketException catch (e) {
      throw NoInternetException(message: "Not connected to internet");
    } catch (e) {
      throw ServerException(message: "With error ${e.toString()}");
    }
  }

  //post
  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? mBodyParams,
    Map<String, String>? mHeaderParams,
    bool isAuth = false,
  }) async {
    // Always initialize headers
    mHeaderParams = mHeaderParams ?? {};

    // Always set content type
    mHeaderParams["Content-Type"] = "application/json";

    if (!isAuth) {
      String token = await getToken();
      if (token.isNotEmpty) {
        mHeaderParams["Authorization"] = "Bearer $token";
      }
    }

    try {
      //print('what is url? $url $mBodyParams $mHeaderParams');
      var response = await http.post(
        Uri.parse(url),
        body: mBodyParams != null ? jsonEncode(mBodyParams) : null,
        headers: mHeaderParams,
      );
      return returnResponse(response);
      // ignore: unused_catch_clause
    } on SocketException catch (e) {
      throw NoInternetException(message: "Not connected to internet");
    } catch (e) {
      throw ServerException(message: "With error ${e.toString()}");
    }
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }

  dynamic returnResponse(http.Response res) {
    switch (res.statusCode) {
      case 200:
        {
          return jsonDecode(res.body);
        }

      case 400:
        {
          throw BadRequestException(
            message: "with status code ${res.statusCode}",
          );
        }

      case 401:
        {
          throw UnauthorizedException(
            message: "with status code ${res.statusCode}",
          );
        }

      case 404:
        {
          throw NotFoundException(
            message: "with status code ${res.statusCode}",
          );
        }

      case 500:
      default:
        {
          throw ServerException(message: "with status code ${res.statusCode}");
        }
    }
  }
}
