import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/l10n/gen/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../ui/core/utils/validators.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/lang_button.dart';
import '../widgets/loading_button.dart';
import 'language_provider.dart';

final getIt = GetIt.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed: $e")),
      );
      return null;
    }
  }

  // Navigate to Register Screen
  void _navigateToRegister() {
    try {
      context.push('/register');
    } catch (e) {

      Navigator.pushNamed(context, '/register');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final langProvider = context.watch<LanguageProvider>();

    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.primaryBlack,
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.go('/home');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.ratingBgColor,
                ),
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),

                    /// --- Logo ---
                    Center(
                      child: Image.asset(
                        "assets/images/login.png",
                        width: 120.w,
                        height: 120.h,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    /// --- Email field ---
                    CustomTextField(
                      controller: _emailController,
                      hintText: lang.emailHint,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => Validators.validateEmail(val,
                          emptyMsg: lang.enterEmailError, invalidMsg: lang.invalidEmailError),
                    ),

                    SizedBox(height: 20.h),

                    /// --- Password field ---
                    CustomTextField(
                      controller: _passwordController,
                      hintText: lang.passwordHint,
                      icon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (val) => Validators.validatePassword(val,
                          emptyMsg: lang.enterPasswordError, lengthMsg: lang.passwordLengthError),
                    ),

                    SizedBox(height: 12.h),

                    /// --- Forgot password ---
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: Text(
                          lang.forgotPassword,
                          style: GoogleFonts.roboto(
                            color: AppColors.yellow,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    /// --- Login Button ---
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return LoadingButton(
                          text: lang.login,
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );
                            }
                          },
                          backgroundColor: AppColors.yellow,
                          textColor: Colors.black,
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lang.noAccount,
                          style: GoogleFonts.roboto(
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: _navigateToRegister,
                          child: Text(
                            lang.signUp,
                            style: GoogleFonts.roboto(
                              color: AppColors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    /// --- Divider with OR ---
                    Row(
                      children: [
                        Expanded(
                          child:
                          Divider(color: AppColors.yellow, thickness: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "OR",
                            style: GoogleFonts.roboto(
                              color: AppColors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child:
                          Divider(color: AppColors.yellow, thickness: 1),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// --- Google Login Button ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final user = await _signInWithGoogle();
                          if (user != null) {
                            context.go('/home');
                          }
                        },
                        icon: Image.asset(
                          "assets/icons/google.png",
                          height: 24.h,
                        ),
                        label: Text(
                          lang.googleLogin,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    /// --- Language Switch ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LangButton(
                          langCode: "en",
                          asset: "assets/icons/LR.png",
                          isSelected: langProvider.currentLangCode == "en",
                          onPressed: () {
                            langProvider.setLang("en");
                          },
                        ),
                        SizedBox(width: 10.w),
                        LangButton(
                          langCode: "ar",
                          asset: "assets/icons/EG.png",
                          isSelected: langProvider.currentLangCode == "ar",
                          onPressed: () {
                            langProvider.setLang("ar");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}