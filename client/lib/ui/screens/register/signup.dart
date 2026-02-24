import 'package:client/main.dart';
import 'package:client/ui/screens/register/login.dart';
import 'package:client/ui/theme/theme.dart';
import 'package:client/ui/widgets/actions/button.dart';
import 'package:client/ui/widgets/inputs/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widget/devider.dart';
import 'widget/google_login.dart';
import 'widget/register_background.dart';

import 'package:client/services/auth_service.dart';
import 'package:dio/dio.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email address is required.";
    }
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address.";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long.";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter.";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number.";
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.length > 15) {
      return "Can not more than 15 characters";
    }
    return null;
  }

  void onSignUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authService.register(
          emailController.text,
          fullNameController.text,
          passwordController.text,
        );
        if (mounted) {
          // navigate to home in phase 5, for now just show success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account created successfully!')),
          );
        }
      } on DioException catch (e) {
        final message = e.response?.data['message'] ?? 'Something went wrong';
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      }
    }
  }

  void onPressGoogle() async {
    try {
      await authService.googleSignIn();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AppRoot()),
          (route) => false,
        );
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Something went wrong';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      if (e.toString().contains('cancelled')) return;
      print(e.toString());
    }
  }

  void onLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose(); 
    emailController.dispose(); 
    passwordController.dispose(); 
    super.dispose();      
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Icon(Icons.arrow_back, color: Colors.white, size: 30,)
      ),  
      body: Stack(
        children: [
          background(),
          mainWidget()
        ],
      )
    );
  }

  Widget mainWidget(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: TosReviewSpacings.xxl),
                Image.asset('assets/images/logo_image.png', height: 100,),
                const SizedBox(height: TosReviewSpacings.m),
                Text("Create your account? ", style: TosReviewTextStyles.heading),
                const SizedBox(height: 5),
                Text("Create your account to explore real experience product Review", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark), textAlign: TextAlign.center,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: TosReviewSpacings.l,),
                      CustomTextField(label: "Full name", hintText: "Enter your full name", text: fullNameController, validator: validateFullName, isRequired: true,),
                      const SizedBox(height: TosReviewSpacings.m),
                      CustomTextField(label: "Email Address", hintText: "Enter your email", text: emailController, validator: validateEmail, isRequired: true,),
                      const SizedBox(height: TosReviewSpacings.m),
                      CustomTextField(label: "Password", hintText: "Enter your password", text: passwordController, validator: validatePassword, isPassword: true, isRequired: true),
                      const SizedBox(height: TosReviewSpacings.l),
                    ]
                  )
                ),
                CustomButton(onPress: onSignUp, name: "Sign up", isLong: true, isRoundBorderRaduis: false),
                const SizedBox(height: TosReviewSpacings.m),
                Devider(),
                const SizedBox(height: TosReviewSpacings.l),
                GoogleLogin(onPress: onPressGoogle),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark, fontFamily: 'Montserrat'),
                    children: [
                      TextSpan(text: "Already a member? "),
                      TextSpan(
                        text: "Login",
                        recognizer: TapGestureRecognizer()
                          ..onTap = onLogin,
                        style: TextStyle(color: TosReviewColors.primary, decoration: TextDecoration.underline,)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}