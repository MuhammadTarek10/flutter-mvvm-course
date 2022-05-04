import 'package:shared_preferences/shared_preferences.dart';
import 'package:stores/presentation/resources/language_manager.dart';

const String prefKeyLang = 'PREF_KEY_LANG';
const String prefKeyOnBoardingScreenViewed = 'ON_BOARDING_VIEWED';
const String prefKeyIsUserLoggedIn = 'IS_USER_LOGGED_IN';
const String prefKeyIsUserRegistered = 'IS_USER_REGISTERED';

class AppPrefrences {
  final SharedPreferences _sharedPreferences;
  AppPrefrences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefKeyOnBoardingScreenViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefKeyOnBoardingScreenViewed) ?? false;
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefKeyIsUserLoggedIn) ?? false;
  }

  Future<void> setUserRegistered() async {
    _sharedPreferences.setBool(prefKeyIsUserRegistered, true);
  }

  Future<bool> isUserRegistered() async {
    return _sharedPreferences.getBool(prefKeyIsUserRegistered) ?? false;
  }
}
