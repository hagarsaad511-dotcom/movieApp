import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/gen/app_localizations.dart';
import '../../ui/core/themes/app_colors.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;
  String? _errorMessage;

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(
        email: _emailController.text.trim(),
      );
    }
  }

  void _navigateBackToLogin() {
    context.pushReplacement('/login');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                setState(() {
                  _emailSent = true;
                  _errorMessage = null;
                });
              } else if (state is AuthError) {
                setState(() {
                  _errorMessage = state.message;
                  _emailSent = false;
                });
              }
            },
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Back Button
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              lang.forgotPassword, // Use translation
                              style: GoogleFonts.roboto(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    /// Error Message
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontSize: 14.sp,
                        ),
                      ),
                    SizedBox(height: _errorMessage != null ? 16.h : 0),

                    if (!_emailSent) ...[

                      /// image
                      Center(
                        child: Image.asset(
                          "assets/images/Forgot password-bro 1.png", // replace with your logo
                          width: 430.w,
                          height: 430.h,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      /// Email Field
                      CustomTextField(
                        controller: _emailController,
                        hintText: lang.email,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.isEmpty) return lang.enterEmailError;
                          if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                            return lang.invalidEmailError;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),

                      /// Send Button
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return LoadingButton(
                            text: lang.sendResetLink,
                            isLoading: state is AuthLoading,
                            onPressed: _onSubmit,
                            backgroundColor: AppColors.yellow,
                            textColor: AppColors.primaryBlack,
                          );
                        },
                      ),
                    ] else ...[
                      /// Success State - Fixed alignment
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Success Icon
                            Icon(
                              Icons.mark_email_read_outlined,
                              size: 80.w,
                              color: AppColors.yellow,
                            ),
                            SizedBox(height: 24.h),

                            /// Success Title
                            Text(
                              lang.emailSent,
                              style: GoogleFonts.roboto(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),

                            /// Success Message
                            Text(
                              lang.resetEmailSent,
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                color: AppColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32.h),

                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: 20.h),

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