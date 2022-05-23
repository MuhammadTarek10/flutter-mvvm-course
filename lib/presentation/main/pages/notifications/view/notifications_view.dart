import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stores/presentation/resources/strings_manager.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.notifications.tr()),
    );
  }
}
