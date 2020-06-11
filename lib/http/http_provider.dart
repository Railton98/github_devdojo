import 'package:github_devdojo/http/http_exception.dart';
import 'package:http/http.dart' as http;

abstract class HttpProvider {
  static const Duration TIME_OUT = const Duration(seconds: 60);
  static const int MIN_STATUS_CODE_ERROR = 400;

  static Future<http.Response> get(String url, {Map<String, String> headers}) async {
    return _validateHttpStatus(await http.get(url, headers: headers).timeout(TIME_OUT));
  }

  static Future<http.Response> post(String url, Object object, {Map<String, String> headers}) async {
    headers = headers ?? {'Content-Type': 'application/json; charset=utf-8'};
    return _validateHttpStatus(await http.post(url, body: object, headers: headers).timeout(TIME_OUT));
  }

  static Future<http.Response> put(String url, Object object, {Map<String, String> headers}) async {
    headers = headers ?? {'Content-Type': 'application/json; charset=utf-8'};
    return _validateHttpStatus(await http.put(url, body: object, headers: headers).timeout(TIME_OUT));
  }

  static Future<http.Response> delete(String url, {Map<String, String> headers}) async {
    return _validateHttpStatus(await http.delete(url, headers: headers).timeout(TIME_OUT));
  }

  static http.Response _validateHttpStatus(http.Response response) {
    if (response.statusCode >= MIN_STATUS_CODE_ERROR) {
      throw HttpException(response);
    }

    return response;
  }
}
