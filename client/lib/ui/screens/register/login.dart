import 'package:client/ui/screens/register/signup.dart';
import 'package:client/ui/screens/register/widget/devider.dart';
import 'package:client/ui/widgets/actions/button.dart';
import 'package:client/ui/widgets/inputs/text_field.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'widget/google_login.dart';
import 'widget/register_background.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;

  void onPressGoogle(){
    print("Log with google");
  }

  void onForgetPassword(){
    print("Forget Password");
  }

  void onLogin(){
    print("Press login");
  }

  void onSignUp(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),  
      body: Stack(
        children: [
          background(),
          mainWidget()
        ],
      )
    );
  }
  @override
  void dispose() {
    emailController.dispose(); 
    passwordController.dispose(); 
    super.dispose();      
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
                Image.asset('assets/images/logo_image.png', height: 100,),
                const SizedBox(height: TosReviewSpacings.m),
                Text("Welcome Back!", style: TosReviewTextStyles.heading),
                const SizedBox(height: 5),
                Text("Sign in to access real , honestly Rate Review mode for you", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark), textAlign: TextAlign.center,),
                const SizedBox(height: TosReviewSpacings.l,),
                CustomTextField(label: "Email Address", hintText: "Enter your email", text: emailController, validator: validateEmail, isRequired: true,),
                const SizedBox(height: TosReviewSpacings.m),
                CustomTextField(label: "Password", hintText: "Enter your password", text: passwordController, validator: validatePassword, isPassword: true, isRequired: true,),
                const SizedBox(height: TosReviewSpacings.m),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact, 
                        ),
                      Text("Remember me", style: TosReviewTextStyles.body),
                      ]
                    ),
                    GestureDetector(
                      onTap: onForgetPassword,
                      child: Text("Forget Password?", style: TosReviewTextStyles.body)
                    )
                  ],
                ),
                const SizedBox(height: TosReviewSpacings.m),
                CustomButton(onPress: onLogin, name: "Log in", isLong: true, isRoundBorderRaduis: false,),
                const SizedBox(height: TosReviewSpacings.m),
                Devider(),
                const SizedBox(height: TosReviewSpacings.m),
                GoogleLogin(onPress: onPressGoogle),
                const SizedBox(height: TosReviewSpacings.m),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark, fontFamily: 'Montserrat'),
                    children: [
                      TextSpan(text: "Don’t You have an Account? "),
                      TextSpan(
                        text: "Sign up",
                        recognizer: TapGestureRecognizer()
                          ..onTap = onSignUp,
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