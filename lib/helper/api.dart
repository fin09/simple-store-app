import 'package:dio/dio.dart';

const String baseUrl = 'http://10.0.2.2:3000';

class Api {
  Dio dio = Dio();

  Future<dynamic> get({required String url}) async {
    try {
      Response response = await dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'there is a problem with status code ${e.response?.statusCode} with body ${e.response?.data}',
      );
    }
  }

  Future<dynamic> post({
    required String url,
    required dynamic body,
    String? token,
    required Map<String, String> headers,
  }) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'Problem with status code ${e.response?.statusCode} '
        'and body ${e.response?.data}',
      );
    }
  }

  Future<dynamic> put({
    required String url,
    required dynamic body,
    Map<String, String>? headers,
    required String id,
  }) async {
    try {
      Response response = await dio.put(
        '$url/$id',
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'there is a problem with status code ${e.response?.statusCode} with body ${e.response?.data}',
      );
    }
  }
}
