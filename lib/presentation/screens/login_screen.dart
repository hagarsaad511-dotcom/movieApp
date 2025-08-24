import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import 'package:movie_app/ui/core/themes/app_colors.dart';

import '/../l10n/gen/app_localizations.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/custom_text_field.dart';
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
                  backgroundColor: AppColors.red,
                ),
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.h),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: const BoxDecoration(
                              color: AppColors.yellow,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.movie,
                              size: 40.sp,
                              color: AppColors.primaryBlack,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            lang.loginTitle,
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            lang.loginSubtitle,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                    CustomTextField(
                      controller: _emailController,
                      hintText: lang.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.lightGrey,
                        size: 20.sp,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) return lang.enterEmailError;
                        if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value!)) {
                          return lang.invalidEmailError;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: lang.passwordHint,
                      obscureText: _obscurePassword,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: AppColors.lightGrey,
                        size: 20.sp,
                      ),
                      suffixIcon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.lightGrey,
                        size: 20.sp,
                      ),
                      onSuffixIconTap: () => setState(() {
                        _obscurePassword = !_obscurePassword;
                      }),
                      validator: (value) {
                        if (value?.isEmpty ?? true) return lang.enterPasswordError;
                        if (value!.length < 6) return lang.passwordLengthError;
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: Text(
                          lang.forgotPassword,
                          style: TextStyle(fontSize: 14.sp, color: AppColors.yellow),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return LoadingButton(
                          text: lang.loginButton,
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${lang.noAccount} ',
                          style: TextStyle(fontSize: 14.sp, color: AppColors.lightGrey),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/register'),
                          child: Text(
                            lang.signUp,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.yellow,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: GestureDetector(
                        onTap: () => langProvider.toggleLang(),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.yellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.language, color: AppColors.yellow),
                              SizedBox(width: 8.w),
                              Text(
                                langProvider.currentLangCode == 'en' ? 'عربي' : 'English',
                                style: const TextStyle(
                                  color: AppColors.yellow,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
