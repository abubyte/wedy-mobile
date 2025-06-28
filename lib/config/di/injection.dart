import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedy/features/authentication/services/authentication_service.dart';
import 'package:wedy/features/authentication/services/authentication_service_impl.dart';
import 'package:wedy/features/authentication/viewmodels/authentication_bloc.dart';
import 'package:wedy/shared/services/api_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt())..configureDio(baseUrl: "https://ready-shepherd-uniquely.ngrok-free.app"),
  );

  registerAuthenticationFeature();
}

void registerAuthenticationFeature() {
  // Services
  getIt.registerLazySingleton<AuthenticationService>(() => AuthenticationServiceImpl(getIt(), getIt()));

  // ViewModels
  getIt.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc(getIt()));
}
