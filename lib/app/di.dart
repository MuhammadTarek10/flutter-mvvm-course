import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stores/app/app_prefs.dart';
import 'package:stores/data/data_source/remote_data_source.dart';
import 'package:stores/data/network/app_api.dart';
import 'package:stores/data/network/dio_factory.dart';
import 'package:stores/data/network/network_info.dart';
import 'package:stores/data/repository/repository_implementer.dart';
import 'package:stores/domain/repository/repository.dart';
import 'package:stores/domain/usecase/login_usecase.dart';
import 'package:stores/domain/usecase/register_usecase.dart';
import 'package:stores/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';
import 'package:stores/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:stores/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // shared pref instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs
  instance
      .registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(instance()));

  // repo
  instance.registerLazySingleton<Reposotiry>(
      () => RepositoryImp(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initOnBoardingModule() {
  if (!GetIt.I.isRegistered<OnBoardingViewModel>()) {
    instance.registerFactory<OnBoardingViewModel>(() => OnBoardingViewModel());
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance()));
  }
}
