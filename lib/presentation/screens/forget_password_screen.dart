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
      context.read<AuthCubit>().forgotPassword(_emailController.text.trim());
    }
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
      backgroundColor: AppColors.primaryBlack,
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
                    /// Header row
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.yellow,
                          ),
                          onPressed: () =>  context.go('/login'),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              lang.forgotPassword,
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

                    /// Error
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

                    /// Before sending
                    if (!_emailSent) ...[
                      Center(
                        child: Image.asset(
                          "assets/images/Forgot password-bro 1.png",
                          width: 320.w,
                          height: 320.h,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      CustomTextField(
                        controller: _emailController,
                        hintText: lang.email,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => Validators.validateEmail(
                          val,
                          emptyMsg: lang.enterEmailError,
                          invalidMsg: lang.invalidEmailError,
                        ),
                      ),
                      SizedBox(height: 24.h),
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
                      /// After email sent
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.mark_email_read_outlined,
                              size: 80.w,
                              color: AppColors.yellow,
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              lang.emailSent,
                              style: GoogleFonts.roboto(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              lang.resetEmailSent,
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                color: AppColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32.h),
                            ElevatedButton(
                              onPressed: () => context.go('/login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.yellow,
                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 24.w,
                                ),
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
