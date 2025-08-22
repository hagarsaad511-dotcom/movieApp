import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection_container.config.dart';

final GetIt sl = GetIt.instance;

@InjectableInit()
Future<void> init() async {
  // Run the generated injectable code
  sl.init();

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker(),
  );
}
