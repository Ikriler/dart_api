import 'package:api_app/utils/api_utils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends QueuedInterceptor {

  SharedPreferences? sharedPreferences;

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    super.onError(error, handler);

    if (error.response!.statusCode == 500 &&
        error.error == "JWT token expired!") {
 sharedPreferences =
          await SharedPreferences.getInstance();
      Map<String, String> tokens = await ApiUtils.S!
          .getTokens(sharedPreferences!.getString("refreshToken") ?? "");
      sharedPreferences!.setString("accessToken", tokens["accessToken"] ?? "");
      sharedPreferences!.setString("refreshToken", tokens["refreshToken"] ?? "");
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences!.getString("accessToken");

    if(token != "" && token!= null) {
      options.headers["Authorization"] = "Bearer $token";
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }
}
