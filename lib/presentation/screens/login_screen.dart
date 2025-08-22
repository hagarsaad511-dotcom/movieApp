import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../ui/core/themes/app_colors.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

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
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
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
                    // Logo and title
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
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Sign in to continue watching',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                    // Email field
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.lightGrey,
                        size: 20.sp,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value!)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    // Password field
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: _obscurePassword,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: AppColors.lightGrey,
                        size: 20.sp,
                      ),
                      suffixIcon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.lightGrey,
                        size: 20.sp,
                      ),
                      onSuffixIconTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.yellow,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    // Login button
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return LoadingButton(
                          text: 'Sign In',
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
                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.lightGrey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/register'),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.yellow,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
