import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedy/shared/utils/dio_logger.dart';

class ApiService {
  // Constructor
  ApiService(this._prefs);

  // Dio instance
  late Dio _dio;
  final SharedPreferences _prefs;

  // Configuration Function
  void configureDio({
    required String baseUrl,
    Map<String, dynamic>? defaultHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    void Function(RequestOptions options, RequestInterceptorHandler handler)? onRequest,
    void Function(Response response, ResponseInterceptorHandler handler)? onResponse,
    void Function(DioException e, ErrorInterceptorHandler handler)? onError,
  }) {
    /// Create Dio instance with Base Options
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers: defaultHeaders ?? {'Content-Type': 'x-www-form-urlencoded', 'Accept': 'application/json'},
      ),
    );

    // Adding interceptors
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest:
            onRequest ??
            (options, handler) async {
              String? token = _prefs.getString('access_token');

              if (token != null) {
                if (JwtDecoder.isExpired(token)) {
                  try {
                    // await sl<AuthenticationRepository>().userLoginCached(); TODO

                    token = _prefs.getString('access_token');
                  } catch (e) {
                    rethrow;
                  }
                }

                options.headers['Authorization'] = 'Bearer $token';
              }

              handler.next(options);
            },
        onResponse:
            onResponse ??
            (response, handler) {
              handler.next(response);
            },
        onError:
            onError ??
            (DioException e, handler) {
              debugPrint('Error: ${e.message}');

              handler.next(e);
            },
      ),

      /// Logger Configuration
      PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true, responseBody: true),
    ]);
  }

  // Get Request
  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post Request
  Future<Response> postRequest(String endpoint, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.post(endpoint, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post FormData Request
  Future<Response> postFormDataRequest(
    String path, {
    required FormData? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(path, data: formData, queryParameters: queryParameters);
  }

  // Delete Request
  Future<Response> deleteRequest(String endpoint, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.delete(endpoint, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Patch Request
  Future<Response> patchRequest(String endpoint, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.patch(endpoint, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put Request
  Future<Response> putRequest(String endpoint, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.put(endpoint, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
