import 'package:flutter/material.dart';
import 'package:stores/app/di.dart';
import 'package:stores/presentation/forget_password/view/forget_password_view.dart';
import 'package:stores/presentation/login/view/login_view.dart';
import 'package:stores/presentation/main/main_view.dart';
import 'package:stores/presentation/onboarding/view/onbording_view.dart';
import 'package:stores/presentation/register/view/register_view.dart';
import 'package:stores/presentation/resources/strings_manager.dart';
import 'package:stores/presentation/splash/splash_view.dart';
import 'package:stores/presentation/store_details/view/store_details_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
  static const String onBoardingRoute = '/onBoadring';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPassowrdView());
      case Routes.onBoardingRoute:
        initOnBoardingModule();
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
