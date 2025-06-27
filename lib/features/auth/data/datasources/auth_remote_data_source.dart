import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String username, String password);
  Future<UserModel> refreshToken(
    String? refreshToken,
  ); // Ritorna il refreshToken come parametro per mobile, null per web (cookie)
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({
    required this.dio,
  }); // Non dipende più da localDataSource

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        // Il refresh token non viene più parsato dal JSON qui per mobile,
        // perché il backend non lo invia più nel body per il web.
        // La logica di "quale token prendere" si sposta al Repository.
        return UserModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else {
        throw ServerException("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else if (e.response?.statusCode == 400) {
        throw BadRequestException();
      }
      throw ServerException("DioException: ${e.message}");
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String username,
    String password,
  ) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {'email': email, 'username': username, 'password': password},
      );
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else {
        throw ServerException("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw BadRequestException();
      }
      throw ServerException("DioException: ${e.message}");
    }
  }

  @override
  Future<UserModel> refreshToken(String? refreshToken) async {
    // Accetta il refreshToken come parametro
    try {
      final response = await dio.post(
        '/auth/refresh-token',
        data: kIsWeb
            ? {} //gestito con cookie per il web
            : {'refreshToken': refreshToken}, // Invia solo se mobile
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException("DioException: ${e.message}");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('/auth/logout');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException("DioException: ${e.message}");
    } catch (e) {
      throw Exception('Failed to logout');
    }
  }
}
