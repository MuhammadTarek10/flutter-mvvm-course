import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import 'package:stores/app/app_prefs.dart';
import 'package:stores/app/di.dart';
import 'package:stores/data/data_source/local_data_source.dart';
import 'package:stores/presentation/resources/assets_manager.dart';
import 'package:stores/presentation/resources/language_manager.dart';
import 'package:stores/presentation/resources/routes_manager.dart';
import 'package:stores/presentation/resources/strings_manager.dart';
import 'package:stores/presentation/resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssetsManager.changeLanguageIc),
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssetsManager.rightArrowSettingsIc),
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssetsManager.contactUsIc),
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssetsManager.rightArrowSettingsIc),
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssetsManager.inviteFriendsIc),
            title: Text(
              AppStrings.inviteYourFriends.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssetsManager.rightArrowSettingsIc),
            ),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssetsManager.logoutIc),
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssetsManager.rightArrowSettingsIc),
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  bool _isRtl() {
    return context.locale == arabicLocale;
  }

  _changeLanguage() {
    _appPrefrences.changeLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs() {}

  _inviteFriends() {}

  _logout() {
    _appPrefrences.logout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
