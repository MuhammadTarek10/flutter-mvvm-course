import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:stores/app/app.dart';
import 'package:stores/app/di.dart';
import 'package:stores/presentation/resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    child: Phoenix(child: const MyApp()),
    supportedLocales: const [arabicLocale, englishLocale],
    path: assetPathLocalisation,
  ));
}
