import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localizations_en.dart';
import 'localizations_id.dart';

/// Application localizations
class AppLocalizations {
  final Locale locale;
  final Map<String, String> _localizedStrings;

  AppLocalizations(this.locale, this._localizedStrings);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  String get appName => translate('app_name');
  String get home => translate('home');
  String get courses => translate('courses');
  String get myLearning => translate('my_learning');
  String get profile => translate('profile');
  String get search => translate('search');
  String get searchCourses => translate('search_courses');
  String get bookmarks => translate('bookmarks');
  String get settings => translate('settings');
  String get continueLearning => translate('continue_learning');
  String get recommendedCourses => translate('recommended_courses');
  String get allCourses => translate('all_courses');
  String get beginner => translate('beginner');
  String get intermediate => translate('intermediate');
  String get advanced => translate('advanced');
  String get expert => translate('expert');
  String get lessons => translate('lessons');
  String get quizzes => translate('quizzes');
  String get completed => translate('completed');
  String get inProgress => translate('in_progress');
  String get notStarted => translate('not_started');
  String get startCourse => translate('start_course');
  String get continueCourse => translate('continue_course');
  String get theme => translate('theme');
  String get language => translate('language');
  String get light => translate('light');
  String get dark => translate('dark');
  String get system => translate('system');
  String get aboutApp => translate('about_app');
  String get version => translate('version');
  String get noCourses => translate('no_courses');
  String get noBookmarks => translate('no_bookmarks');
  String get loading => translate('loading');
  String get error => translate('error');
  String get retry => translate('retry');
  
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'id'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    Map<String, String> localizedStrings;
    
    switch (locale.languageCode) {
      case 'id':
        localizedStrings = localizationsId;
        break;
      case 'en':
      default:
        localizedStrings = localizationsEn;
        break;
    }
    
    return AppLocalizations(locale, localizedStrings);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Current locale provider with persistence
final currentLocaleProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  static const _key = 'locale';

  LocaleNotifier() : super(const Locale('en')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_key);

    if (savedLocale != null) {
      state = Locale(savedLocale);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }
}
