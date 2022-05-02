import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stores/app/app_prefs.dart';
import 'package:stores/app/di.dart';
import 'package:stores/presentation/resources/assets_manager.dart';
import 'package:stores/presentation/resources/color_manager.dart';
import 'package:stores/presentation/resources/constant_manager.dart';
import 'package:stores/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPrefrences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      } else {
        _appPrefrences.isOnBoardingScreenViewed().then((isOnBoardingViewed) {
          if (isOnBoardingViewed) {
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          } else {
            Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssetsManager.splashLogo),
        ),
      ),
    );
  }
}
