import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String getBaseUrl() {
  return dotenv.get('SERVER');
}

Future<BaseOptions> getProtectedBaseOption() async {
  final secureStorage = FlutterSecureStorage();
  final token = await secureStorage.read(key: 'access_token');

  return BaseOptions(
      baseUrl: getBaseUrl(),
      headers: {'Authorization': 'Bearer $token'},
      contentType: Headers.jsonContentType);
}

BaseOptions getPublicBaseOption() {
  return BaseOptions(
      baseUrl: getBaseUrl(), contentType: Headers.jsonContentType);
}
