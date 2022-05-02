import 'package:shared_preferences/shared_preferences.dart';
import 'package:stores/presentation/resources/language_manager.dart';

const String prefKeyLang = 'PREF_KEY_LANG';

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
}
