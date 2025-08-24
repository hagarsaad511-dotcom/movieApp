// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get loginTitle => 'مرحباً بعودتك!';

  @override
  String get loginSubtitle => 'سجّل الدخول لمتابعة المشاهدة';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get googleLogin => 'سجّل دخولك باستخدام جوجل';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get language => 'اللغة';

  @override
  String get enterEmailError => 'الرجاء إدخال البريد الإلكتروني';

  @override
  String get invalidEmailError => 'الرجاء إدخال بريد إلكتروني صالح';

  @override
  String get enterPasswordError => 'الرجاء إدخال كلمة المرور';

  @override
  String get passwordLengthError =>
      'يجب أن تتكوّن كلمة المرور من 6 أحرف على الأقل';
}
