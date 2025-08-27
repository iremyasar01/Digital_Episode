import 'package:dio/dio.dart';
import 'package:digital_episode/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';

/// Dio HTTP client sınıfı - Singleton pattern yerine basit constructor
/// GetIt ile dependency injection için uygun hale getirildi
class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.BASE_URL,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _setupInterceptors();
  }

  /// Interceptor'ları kur - tüm istek ve yanıtları logla
  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Tüm isteklere API key ekle
        options.queryParameters['api_key'] = ApiConstants.API_KEY;
        
        debugPrint('🚀 REQUEST[${options.method}] => PATH: ${options.path}');
        debugPrint('📋 Query Parameters: ${options.queryParameters}');
        
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('❌ ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');
        debugPrint('📍 PATH: ${e.requestOptions.path}');
        return handler.next(e);
      },
    ));
  }

  /// GET isteği yap
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException {
      rethrow; // Hata yakalama işlemini caller'a bırak
    }
  }

  // Diğer HTTP metodları (POST, PUT, DELETE) buraya eklenebilir
}