import 'package:client/ui/screens/register/login.dart';
import 'package:client/ui/screens/register/signup.dart';
import 'package:client/ui/theme/theme.dart';
import 'package:client/ui/widgets/actions/button.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});
  void onLogin(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
  void onSignup(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      backgroundColor: Colors.white, 
      body: Stack(
        children: [
          background(),
          mainWidget(context)
        ],
      )
    );
  }

  Widget background(){
    return Container(
      width: double.infinity,
      height: 700,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 1.0], 
          colors: [Color.fromARGB(255, 196, 230, 226), Colors.white],
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context){
    return Column(
      children: [
        const SizedBox(height: 20),
        Image.asset('assets/images/splash/photos.png'),
        Padding(
          padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_image.png', height: 100,),
              const SizedBox(height: TosReviewSpacings.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Discover ", style: TosReviewTextStyles.title),
                  Text("Tos Review", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary))
                ],
              ),
              Text("Understand", style: TosReviewTextStyles.title),
              const SizedBox(height: TosReviewSpacings.l),
              CustomButton(onPress: () => onSignup(context), name: "Sign Up", isLong: true, isRoundBorderRaduis: false,),
              const SizedBox(height: TosReviewSpacings.s),
              CustomButton(onPress: () => onLogin(context), name: "Login", isLong: true, isRoundBorderRaduis: false, backgroundColor: Colors.grey, textColor: Colors.white,),
              const SizedBox(height: TosReviewSpacings.m),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark, fontFamily: 'Montserrat'),
                  children: [
                    TextSpan(text: "By continue , you agree to "),
                    TextSpan(
                        text: "TosReview",
                        style: TextStyle(color: TosReviewColors.primary, decoration: TextDecoration.underline,)),
                    TextSpan(text: " and acknowlegdge your have read our "),
                  ],
                ),
              )

            ],
          ),
        )

      ],
    );
  }
}