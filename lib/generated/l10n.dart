// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get project {
    return Intl.message(
      'Project',
      name: 'project',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get me {
    return Intl.message(
      'Me',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Collect`
  String get collect {
    return Intl.message(
      'Collect',
      name: 'collect',
      desc: '',
      args: [],
    );
  }

  /// `Rank`
  String get rank {
    return Intl.message(
      'Rank',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Globalization`
  String get globalization {
    return Intl.message(
      'Globalization',
      name: 'globalization',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get chinese {
    return Intl.message(
      'Chinese',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Input Account Please`
  String get input_account {
    return Intl.message(
      'Input Account Please',
      name: 'input_account',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get pwd {
    return Intl.message(
      'Password',
      name: 'pwd',
      desc: '',
      args: [],
    );
  }

  /// `Input Password Please`
  String get input_pwd {
    return Intl.message(
      'Input Password Please',
      name: 'input_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get login_success {
    return Intl.message(
      'Login Success',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Login Fail`
  String get login_fail {
    return Intl.message(
      'Login Fail',
      name: 'login_fail',
      desc: '',
      args: [],
    );
  }

  /// `Collect Success`
  String get collect_success {
    return Intl.message(
      'Collect Success',
      name: 'collect_success',
      desc: '',
      args: [],
    );
  }

  /// `Collect Fail`
  String get collect_fail {
    return Intl.message(
      'Collect Fail',
      name: 'collect_fail',
      desc: '',
      args: [],
    );
  }

  /// `UnCollect Success`
  String get uncollect_success {
    return Intl.message(
      'UnCollect Success',
      name: 'uncollect_success',
      desc: '',
      args: [],
    );
  }

  /// `UnCollect Success`
  String get uncollect_fail {
    return Intl.message(
      'UnCollect Success',
      name: 'uncollect_fail',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login out success`
  String get logout_success {
    return Intl.message(
      'Login out success',
      name: 'logout_success',
      desc: '',
      args: [],
    );
  }

  /// `Login out fail`
  String get logout_fail {
    return Intl.message(
      'Login out fail',
      name: 'logout_fail',
      desc: '',
      args: [],
    );
  }

  /// `Sure`
  String get ok {
    return Intl.message(
      'Sure',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Login first`
  String get login_first {
    return Intl.message(
      'Login first',
      name: 'login_first',
      desc: '',
      args: [],
    );
  }

  /// `Loading......`
  String get loading {
    return Intl.message(
      'Loading......',
      name: 'loading',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
