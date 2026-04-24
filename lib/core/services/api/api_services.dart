import 'package:dio/dio.dart';
import 'package:marketi/core/services/api/data_base_sevices.dart';

class ApiServices extends DataBaseServices {
  final Dio dio;
  final String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1';
  ApiServices(this.dio);

  @override
  Future<dynamic> getData({required String path, String? token}) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    final response = await dio.get(
      "$baseUrl$path",
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> postData({
    required String path,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    final response = await dio.post(
      "$baseUrl$path",
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> patchData({
    required String path,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    final response = await dio.patch(
      "$baseUrl$path",
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> deleteData({required String path, Map<String, dynamic>? data, String? token}) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    final response = await dio.delete(
      "$baseUrl$path",
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
