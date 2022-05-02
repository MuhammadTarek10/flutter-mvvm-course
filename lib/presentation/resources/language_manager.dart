enum LanguageType { english, arabic }

const String arabic = "ar";
const String english = "ar";

extension LanguageTypeExtenstion on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}
