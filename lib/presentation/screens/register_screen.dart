import 'package:flutter/material.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../l10n/gen/app_localizations.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/lang_button.dart';
import '../widgets/loading_button.dart';
import '../widgets/avatar_picker.dart';
import 'language_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _selectedAvatarPath;

  void _onSubmit() {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
        lang: langProvider.currentLangCode,
        avatar: _selectedAvatarPath?? '',
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Top Row (Back Arrow + Register)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
                        onPressed: () => context.pop(),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            lang.register,
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

                  /// Avatar Picker
                  Center(
                    child: Column(
                      children: [
                        AvatarPicker(
                          onAvatarSelected: (avatarPath) {
                            setState(() {
                              _selectedAvatarPath = avatarPath;
                            });
                          },
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          lang.avatar,
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  /// Name
                  CustomTextField(
                    controller: _nameController,
                    hintText: lang.name,
                    icon: Icons.person_outline,
                    validator: (val) =>
                    val == null || val.isEmpty ? lang.enterNameError : null,
                  ),
                  SizedBox(height: 16.h),

                  /// Email
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
                  SizedBox(height: 16.h),

                  /// Password
                  CustomTextField(
                    controller: _passwordController,
                    hintText: lang.password,
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) return lang.enterPasswordError;
                      if (val.length < 6) return lang.passwordLengthError;
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  /// Confirm Password
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: lang.confirmPassword,
                    icon: Icons.lock_outline,
                    obscureText: _obscureConfirmPassword,
                    suffix: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Confirm your password";
                      if (val != _passwordController.text) return lang.passwordsNotMatch;
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  /// Phone Number
                  CustomTextField(
                    controller: _phoneController,
                    hintText: lang.phoneNumber,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (val) =>
                    val == null || val.isEmpty ? lang.enterPhoneError : null,
                  ),
                  SizedBox(height: 24.h),

                  /// Register Button
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return LoadingButton(
                        text: lang.createAccount,
                        isLoading: state is AuthLoading,
                        onPressed: _onSubmit,
                        backgroundColor: AppColors.yellow,
                        textColor: AppColors.primaryBlack,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),

                  /// Already Have Account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${lang.alreadyHaveAccount} ",
                        style: GoogleFonts.roboto(color: AppColors.white),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/login'),
                        child: Text(
                          lang.login,
                          style: GoogleFonts.roboto(
                            color: AppColors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  /// Language Switcher
                  Builder(
                    builder: (context) {
                      final langProvider = Provider.of<LanguageProvider>(context);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LangButton(
                            langCode: "en",
                            asset: "assets/icons/LR.png",
                            isSelected: langProvider.currentLangCode == "en",
                            onPressed: () => langProvider.setLang("en"),
                          ),
                          SizedBox(width: 10.w),
                          LangButton(
                            langCode: "ar",
                            asset: "assets/icons/EG.png",
                            isSelected: langProvider.currentLangCode == "ar",
                            onPressed: () => langProvider.setLang("ar"),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}