

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier(String initialLanguage) : super(initialLanguage);

  void setLanguage(String language) {
    state = _getLanguageCode(language);
  }

  String _getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
            case 'Português':
        return 'pt';
            case 'Italiano':
        return 'it';
            case 'Français':
        return 'fr';
            case 'Español':
        return 'es';
            case 'Deutsch':
        return 'de';
            case 'Nederlands':
        return 'nl';
            case '中文':
        return 'zh';
            case '日本語':
        return 'ja';
            case 'हिन्दी':
        return 'hi';
            default:
        return 'en'; // Default to English if language is not recognized
    }
  }
}

final selectedLanguageProvider =
    StateNotifierProvider<LanguageNotifier, String>((ref) {
  return LanguageNotifier('en'); // Default to English code
});


class LanguageNameNotifier extends StateNotifier<String> {
  LanguageNameNotifier(String initialLanguage) : super(initialLanguage);

  void setLanguage(String language) {
    state = language;
  }
}

final selectectedLanguageName = StateNotifierProvider<LanguageNameNotifier, String>((ref) {
  return LanguageNameNotifier('English'); // Default to English code
});