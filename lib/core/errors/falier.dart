import 'package:dio/dio.dart';

class Failer {
  final String errorMessage;

  Failer({required this.errorMessage});
}

class ApiError extends Failer {
  ApiError({required super.errorMessage});

  factory ApiError.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(errorMessage: 'Connection timeout with API');

      case DioExceptionType.sendTimeout:
        return ApiError(errorMessage: 'Send timeout with API');

      case DioExceptionType.receiveTimeout:
        return ApiError(errorMessage: 'Receive timeout with API');

      case DioExceptionType.badCertificate:
        return ApiError(errorMessage: 'Bad certificate received');

      case DioExceptionType.badResponse:
        return ApiError.fromResponse(
          dioException.response?.statusCode ?? 0,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return ApiError(
          errorMessage: 'Request was cancelled, please try again!',
        );

      case DioExceptionType.connectionError:
        return ApiError(
          errorMessage: 'No internet connection, please try again!',
        );

      case DioExceptionType.unknown:
        return ApiError(errorMessage: 'Unexpected error, please try again!');
    }
  }

  factory ApiError.fromResponse(int statusCode, dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('message')) {
        return ApiError(
          errorMessage: responseData['message'] ?? 'Unknown error',
        );
      }

      if (responseData['error'] != null &&
          responseData['error'] is Map &&
          responseData['error']['message'] != null) {
        return ApiError(errorMessage: responseData['error']['message']);
      }
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ApiError(errorMessage: 'Unauthorized request, please try again!');
    } else if (statusCode == 404) {
      return ApiError(
        errorMessage: 'Your request not found, please try later!',
      );
    } else if (statusCode == 500) {
      return ApiError(errorMessage: 'Server error, please try later!');
    }

    return ApiError(errorMessage: 'Unexpected error, please try again!');
  }
}
