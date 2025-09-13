import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/gen/app_localizations.dart';
import '../../ui/core/themes/app_colors.dart';
import '../../ui/core/utils/validators.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  String? _errorMessage;
  bool _success = false;

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().resetPassword(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      );
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                setState(() {
                  _success = true;
                  _errorMessage = null;
                });
              } else if (state is AuthError) {
                setState(() {
                  _success = false;
                  _errorMessage = state.message;
                });
              }
            },
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Header
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: AppColors.yellow),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              lang.resetPassword,
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

                    /// Error message
                    if (_errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Text(
                          _errorMessage!,
                          style: GoogleFonts.roboto(
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),

                    if (!_success) ...[
                      /// Old password
                      CustomTextField(
                        controller: _oldPasswordController,
                        hintText: lang.oldPassword,
                        icon: Icons.lock_outline,
                        obscureText: _obscureOld,
                        suffix: IconButton(
                          icon: Icon(
                            _obscureOld
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() => _obscureOld = !_obscureOld);
                          },
                        ),
                        validator: (val) => Validators.validatePassword(
                          val,
                          emptyMsg: lang.enterPasswordError,
                          lengthMsg: lang.passwordLengthError,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// New password
                      CustomTextField(
                        controller: _newPasswordController,
                        hintText: lang.newPassword,
                        icon: Icons.lock_outline,
                        obscureText: _obscureNew,
                        suffix: IconButton(
                          icon: Icon(
                            _obscureNew
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() => _obscureNew = !_obscureNew);
                          },
                        ),
                        validator: (val) => Validators.validatePassword(
                          val,
                          emptyMsg: lang.enterPasswordError,
                          lengthMsg: lang.passwordLengthError,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// Confirm password
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: lang.confirmPassword,
                        icon: Icons.lock_outline,
                        obscureText: _obscureConfirm,
                        suffix: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() =>
                            _obscureConfirm = !_obscureConfirm);
                          },
                        ),
                        validator: (val) =>
                            Validators.validateConfirmPassword(
                              val,
                              _newPasswordController.text,
                              mismatchMsg: lang.passwordsNotMatch,
                            ),
                      ),
                      SizedBox(height: 24.h),

                      /// Reset button
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return LoadingButton(
                            text: lang.resetPassword,
                            isLoading: state is AuthLoading,
                            onPressed: _onSubmit,
                            backgroundColor: AppColors.yellow,
                            textColor: AppColors.primaryBlack,
                          );
                        },
                      ),
                    ] else ...[
                      /// Success message
                      Icon(
                        Icons.check_circle_outline,
                        size: 100.w,
                        color: AppColors.yellow,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        lang.passwordResetSuccess,
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellow,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () => context.go('/login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          padding: EdgeInsets.symmetric(
                              vertical: 14.h, horizontal: 24.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          lang.backToLogin,
                          style: GoogleFonts.roboto(
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
