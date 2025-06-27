import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb; // Per distinguere piattaforma
import 'package:wori_app_frontend/core/network/network_info.dart';
import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart'; // Importa UserModel

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel remoteUser = await remoteDataSource.login(
          email,
          password,
        );
        // La logica di salvataggio dei token e dell'utente si sposta qui
        await localDataSource.saveAccessToken(remoteUser.accessToken!);
        if (!kIsWeb && remoteUser.refreshToken != null) {
          await localDataSource.saveRefreshTokenMobile(
            remoteUser.refreshToken!,
          );
        }
        await localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on BadRequestException {
        return Left(BadRequestFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(
    String email,
    String username,
    String password,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel remoteUser = await remoteDataSource.register(
          email,
          username,
          password,
        );
        // La logica di salvataggio dei token e dell'utente si sposta qui
        await localDataSource.saveAccessToken(remoteUser.accessToken!);
        if (!kIsWeb && remoteUser.refreshToken != null) {
          await localDataSource.saveRefreshTokenMobile(
            remoteUser.refreshToken!,
          );
        }
        await localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      } on BadRequestException {
        return Left(BadRequestFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> refreshToken() async {
    if (await networkInfo.isConnected) {
      try {
        String? refreshTokenForMobile;
        if (!kIsWeb) {
          refreshTokenForMobile = await localDataSource.getRefreshTokenMobile();
          if (refreshTokenForMobile == null) {
            throw UnauthorizedException(); // No refresh token available for mobile
          }
        }
        // Chiamata a remoteDataSource.refreshToken() con il token (o null per web)
        final UserModel remoteUser = await remoteDataSource.refreshToken(
          refreshTokenForMobile,
        );

        // Salva il nuovo access token e refresh token (se mobile)
        await localDataSource.saveAccessToken(remoteUser.accessToken!);
        if (!kIsWeb && remoteUser.refreshToken != null) {
          await localDataSource.saveRefreshTokenMobile(
            remoteUser.refreshToken!,
          );
        }
        await localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      } on UnauthorizedException {
        await localDataSource
            .clearCachedUser(); // Invalida tutti i token locali se refresh fallisce
        return Left(UnauthorizedFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    // Il logout lato server potrebbe fallire, ma vogliamo comunque pulire i token locali
    try {
      await remoteDataSource
          .logout(); // Il backend gestirà la cancellazione del cookie
      await localDataSource
          .clearCachedUser(); // Pulisce access token e refresh token mobile
      return Right(null);
    } on Exception {
      // Cattura tutte le eccezioni, incluse ServerException e UnauthorizedException
      await localDataSource.clearCachedUser(); // Assicurati di pulire comunque
      return Left(OtherFailure('Failed to logout.'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCachedUser() async {
    try {
      final user = await localDataSource.getCachedUser();
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
