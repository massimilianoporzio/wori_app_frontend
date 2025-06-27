import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:wori_app_frontend/core/network/app_http_client.dart';
import 'package:wori_app_frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:wori_app_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:wori_app_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:wori_app_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/login_use_case.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/logout_use_case.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/refresh_token_use_case.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/register_use_case.dart';
import 'package:wori_app_frontend/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUser: sl(),
      registerUser: sl(),
      refreshTokenUseCase: sl(),
      logoutUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => RefreshToken(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<AppHttpClient>().dio),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: sl(),
      secureStorage: kIsWeb ? null : sl(),
    ),
  );
}
