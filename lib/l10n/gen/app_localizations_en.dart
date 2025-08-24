// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Welcome Back!';

  @override
  String get loginSubtitle => 'Sign in to continue watching';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'Log In';

  @override
  String get googleLogin => 'Sign in with Google';

  @override
  String get noAccount => 'Don’t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get language => 'Language';

  @override
  String get enterEmailError => 'Please enter your email';

  @override
  String get invalidEmailError => 'Please enter a valid email';

  @override
  String get enterPasswordError => 'Please enter your password';

  @override
  String get passwordLengthError => 'Password must be at least 6 characters';
}
