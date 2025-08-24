// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:movie_app/presentation/screens/login_screen.dart';
// import '../../ui/core/di/injection_container.dart';
//
// import '../../ui/core/themes/app_colors.dart';
// import '../cubits/auth/auth_cubit.dart';
// import '../cubits/auth/auth_state.dart';
// import '../widgets/custom_text_field.dart';
// import '../widgets/loading_button.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<AuthCubit>(),
//       child: Scaffold(
//         backgroundColor: AppColors.primaryBlack,
//         appBar: AppBar(
//           backgroundColor: AppColors.primaryBlack,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () => context.pop(),
//             icon: Icon(
//               Icons.arrow_back,
//               color: AppColors.white,
//               size: 24.sp,
//             ),
//           ),
//         ),
//         body: BlocListener<AuthCubit, AuthState>(
//           listener: (context, state) {
//             if (state is AuthAuthenticated) {
//               context.go('/home');
//             } else if (state is AuthError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: AppColors.red,
//                 ),
//               );
//             }
//           },
//           child: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.all(24.w),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title
//                     Text(
//                       'Create Account',
//                       style: TextStyle(
//                         fontSize: 28.sp,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Sign up to start watching movies',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: AppColors.lightGrey,
//                       ),
//                     ),
//                     SizedBox(height: 48.h),
//                     // Name field
//                     CustomTextField(
//                       controller: _nameController,
//                       hintText: 'Full Name',
//                       prefixIcon: Icon(
//                         Icons.person_outlined,
//                         color: AppColors.lightGrey,
//                         size: 20.sp,
//                       ),
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20.h),
//                     // Email field
//                     CustomTextField(
//                       controller: _emailController,
//                       hintText: 'Email',
//                       keyboardType: TextInputType.emailAddress,
//                       prefixIcon: Icon(
//                         Icons.email_outlined,
//                         color: AppColors.lightGrey,
//                         size: 20.sp,
//                       ),
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                             .hasMatch(value!)) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                         },
//                     ),
//                     SizedBox(height: 20.h),
//                     // Password field
//                     CustomTextField(
//                       controller: _passwordController,
//                       hintText: 'Password',
//                       obscureText: _obscurePassword,
//                       prefixIcon: Icon(
//                         Icons.lock_outlined,
//                         color: AppColors.lightGrey,
//                         size: 20.sp,
//                       ),
//                       suffixIcon: Icon(
//                         _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                         color: AppColors.lightGrey,
//                         size: 20.sp,
//                       ),
//                       onSuffixIconTap: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter your password';
//                         }
//                         if (value!.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20.h),
//                     // Confirm password field
//                     CustomTextField(
//                       controller: _confirmPasswordController,
//                       hintText: 'Confirm Password',
//                       obscureText: _obscureConfirmPassword,
//                       prefixIcon: Icon(
//                         Icons.lock_outlined,
//                         color: AppColors.lightGrey,
//                         size: 20.sp,
//                       ),
//                       suffixIcon: Icon(
//                         _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                         color: AppColors.lightGrey,
//                         size: 20.sp,
//                       ),
//                       onSuffixIconTap: () {
//                         setState(() {
//                           _obscureConfirmPassword = !_obscureConfirmPassword;
//                         });
//                       },
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please confirm your password';
//                         }
//                         if (value != _passwordController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 32.h),
//                     // Register button
//                     BlocBuilder<AuthCubit, AuthState>(
//                       builder: (context, state) {
//                         return LoadingButton(
//                           text: 'Create Account',
//                           isLoading: state is AuthLoading,
//                           onPressed: () {
//                             if (_formKey.currentState?.validate() ?? false) {
//                               context.read<AuthCubit>().register(
//                                 name: _nameController.text.trim(),
//                                 email: _emailController.text.trim(),
//                                 password: _passwordController.text,
//                                 passwordConfirmation: _confirmPasswordController.text,
//                               );
//                             }
//                           },
//                         );
//                       },
//                     ),
//                     const Spacer(),
//                     // Sign in link
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Already have an account? ',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: AppColors.lightGrey,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => context.pop(),
//                           child: Text(
//                             'Sign In',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: AppColors.yellow,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }