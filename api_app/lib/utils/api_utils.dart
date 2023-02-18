import 'package:api_app/interceptors/auth_interceptor.dart';
import 'package:api_app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:requests/requests.dart';

class ApiUtils {
  static ApiUtils? S;

  late Dio dio;

  late SharedPreferences sharedPreferences;

  ApiUtils() {
    _initDio();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _initDio() async {
    // ignore: unnecessary_new
    dio = new Dio(
      BaseOptions(
          baseUrl: "http://localhost:8888",
          connectTimeout: const Duration(milliseconds: 3000),
          receiveTimeout: const Duration(milliseconds: 3500),
          sendTimeout: const Duration(milliseconds: 3500)),
    );

    dio.options.headers["content-type"] = "application/json";

    dio.interceptors.add(AuthInterceptor());
  }

  Future<Map<String, String>> getTokens(String refreshToken) async {
    Map<String, String> tokens = new Map<String, String>();
    try {
      if (refreshToken != "") {
        final response = await this.dio.post("/token" + refreshToken);
        tokens.addAll({
          "accessToken": response.data["data"]["accessToken"],
          "refreshToken": response.data["data"]["refreshToken"]
        });
      }
    } finally {
      return tokens;
    }
  }

  Future<bool> login(String userName, String password) async {
    try {
      final response = await dio.post("/token",
          data: Map.from({'userName': userName, 'password': password}));
      if (response.statusCode == 200) {
        sharedPreferences.setString(
            "accessToken", response.data["data"]["accessToken"]);
        sharedPreferences.setString(
            "refreshToken", response.data["data"]["refreshToken"]);
        return true;
      }
      return false;
    } on DioError catch (error) {
      print(error);
      return false;
    }
  }
}
