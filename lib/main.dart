import 'package:flutter/material.dart';
import 'package:stores/app/app.dart';
import 'package:stores/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}
