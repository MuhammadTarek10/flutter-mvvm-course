import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp._sharedInsatnce();
  static final _shared = MyApp._sharedInsatnce();
  factory MyApp() => _shared;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
