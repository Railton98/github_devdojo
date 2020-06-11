import 'package:http/http.dart';

class HttpException implements Exception {
  final Response _response;

  const HttpException(this._response);

  Map<String, String> get headers => this._response.headers;

  int get statusCode => this._response.statusCode;

  String get body => this._response.body;
}
