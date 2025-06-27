import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:wori_app_frontend/core/services/service_locator.dart';
import 'package:wori_app_frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:wori_app_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:wori_app_frontend/features/auth/presentation/bloc/auth_bloc.dart'; // Importa String.fromEnvironment

class AppHttpClient {
  final Dio _dio;

  Dio get dio => _dio;

  AppHttpClient() : _dio = Dio() {
    // Determina il base URL in base alla piattaforma e alle variabili d'ambiente
    final String baseUrl = kIsWeb
        ? const String.fromEnvironment(
            'BACKEND_BASE_URL_WEB',
            defaultValue: 'http://localhost:3000/api',
          )
        : const String.fromEnvironment(
            'BACKEND_BASE_URL_MOBILE',
            defaultValue: 'http://10.0.2.2:3000/api',
          );

    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    _dio.options.headers['Content-Type'] = 'application/json';

    _dio.options.validateStatus = (status) {
      return status != null && status < 500;
    };

    final cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await sl<AuthLocalDataSource>().getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 &&
              e.response?.data != null &&
              e.response?.data['message'] == 'TokenExpiredError' &&
              e.requestOptions.path != '/auth/refresh-token') {
            try {
              final authRepository = sl<AuthRepository>();
              final userEither = await authRepository.refreshToken();

              if (userEither.isRight()) {
                final newAccessToken = userEither.fold(
                  (l) => null,
                  (user) => user.accessToken,
                );
                if (newAccessToken != null) {
                  e.requestOptions.headers['Authorization'] =
                      'Bearer $newAccessToken';
                  return handler.resolve(
                    await _dio.fetch(
                      e.requestOptions.copyWith(
                        headers: e.requestOptions.headers,
                        data: e.requestOptions.data,
                      ),
                    ),
                  );
                }
              }
            } on Exception catch (_) {
              await sl<AuthLocalDataSource>().clearCachedUser();
              sl<AuthBloc>().add(LogoutRequested());
              return handler.next(e);
            }
          }
          if (e.response?.statusCode == 401) {
            if (e.response?.data != null &&
                e.response?.data['message'] ==
                    'Refresh token expired. Please login again.') {
              await sl<AuthLocalDataSource>().clearCachedUser();
              sl<AuthBloc>().add(LogoutRequested());
            }
          }
          return handler.next(e);
        },
      ),
    );
  }
}
