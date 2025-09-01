import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/auth_usecases.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/datasources/local_datasource.dart';
import '../../../presentation/cubits/auth/auth_cubit.dart';
import '../../../ui/core/network/api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker(),
  );

  // Dio client
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://your-api-base-url.com", // TODO: replace with real base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    // Add interceptors if needed (logging, auth, etc.)
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  });

  // ApiService
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(sl<SharedPreferences>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<LocalDataSource>(),
      sharedPreferences: sl<SharedPreferences>(),
      connectionChecker: sl<InternetConnectionChecker>(),
    ),
  );

  // Use cases - FIXED: Register all use cases properly
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => IsLoggedInUseCase(sl<AuthRepository>()));

  // Cubit - FIXED: Add all required use cases
  sl.registerFactory<AuthCubit>(() => AuthCubit(
    sl<LoginUseCase>(),
    sl<RegisterUseCase>(),
    sl<ForgotPasswordUseCase>(),
    sl<UpdateProfileUseCase>(),
  ));
}