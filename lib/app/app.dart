import 'package:flutter/material.dart';
import 'package:stores/app/app_prefs.dart';
import 'package:stores/app/di.dart';
import 'package:stores/presentation/resources/routes_manager.dart';
import 'package:stores/presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();

  @override
  void didChangeDependencies() {
    _appPrefrences.getLocale().then((locale) => {context.setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
