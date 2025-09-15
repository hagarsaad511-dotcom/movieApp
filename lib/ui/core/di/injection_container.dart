import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/auth_usecases.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/datasources/local_datasource.dart';
import '../../../presentation/cubits/auth/auth_cubit.dart';
import '../network/api_service.dart';
import '../network/dio_client.dart';
final sl = GetIt.instance;

Future<void> init() async {
  // ---------------------------
  // External dependencies
  // ---------------------------
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnectionChecker>(
          () => InternetConnectionChecker());

  // ---------------------------
  // Core (Dio + Retrofit ApiService)
  // ---------------------------
  sl.registerLazySingleton<Dio>(() => DioClient.createAuthDio(sharedPreferences));
  sl.registerLazySingleton<ApiService>(() => ApiService(
    sl<Dio>(),
    baseUrl: "https://route-movie-apis.vercel.app/",
  ));

  // ---------------------------
  // Data sources
  // ---------------------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(sl<ApiService>()));
  sl.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImpl(sl<SharedPreferences>()));

  // ---------------------------
  // Repository
  // ---------------------------
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    sl<AuthRemoteDataSource>(),
    sl<LocalDataSource>(),
    sharedPreferences: sl<SharedPreferences>(),
    connectionChecker: sl<InternetConnectionChecker>(),
  ));

  // ---------------------------
  // Use cases
  // ---------------------------
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => IsLoggedInUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(
    sl<AuthRepository>(),
    sl<LocalDataSource>(),
  ));

  // ---------------------------
  // Cubits
  // ---------------------------
  sl.registerFactory<AuthCubit>(() => AuthCubit(
    sl<LoginUseCase>(),
    sl<RegisterUseCase>(),
    sl<ResetPasswordUseCase>(),
    sl<UpdateProfileUseCase>(),
    sl<GetCurrentUserUseCase>(),
    sl<LogoutUseCase>(),
    sl<DeleteAccountUseCase>(),
    sl<GoogleLoginUseCase>(),
  ));
}
