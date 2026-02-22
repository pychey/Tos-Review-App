import 'package:client/ui/screens/splash/register.dart';
import 'package:client/ui/screens/splash/splash3.dart';
import 'package:client/ui/theme/theme.dart';
import 'package:client/ui/widgets/displays/splash_bottom_info.dart';
import 'package:flutter/material.dart';

import 'widget/custom_app_bar.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});
  
  void onNext(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Splash3()),
    );
  }
  void onSkip(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: customAppBar(() => onSkip(context)), 
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
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 1.0], 
          colors: [Color.fromARGB(255, 196, 230, 226), Colors.white],
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(37, 48, 165, 136),
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset('assets/images/splash/hand.png', height: 250,)
                ),
                Positioned(
                  bottom: 150,
                  right: 40,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Image.asset('assets/images/splash/heart.png', height: 40,)
                  )
                ),
                Positioned(
                  bottom: 50,
                  right: 40,
                  child: Image.asset('assets/images/splash/post.png', height: 110,)
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Image.asset('assets/images/splash/heart.png', height: 40,)
                  )
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), 
                  blurRadius: 10,   
                  spreadRadius: 2, 
                  offset: Offset(0, 4), 
                ),
              ],
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 227, 226, 226)
                  ),
                  child: Image.asset('assets/images/splash/verify.png', height: 50, width: 50,)
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trusted by 100k+ users", style: TosReviewTextStyles.body,),
                      const SizedBox(height: 3),
                      Text("Find the best products, avoid scams, and read what real people think before you buy.", style: TosReviewTextStyles.small.copyWith(color: TosReviewColors.greyDark), textAlign: TextAlign.start),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: TosReviewSpacings.xxl),
        SplashBottomInfo(
          title: "Real Review, Real people", 
          onPress: () => onNext(context), 
          subTitle: "Get unbiased product review and rating  from real customers, make decisions with detailed comparisons and expert analysis")
      ],
    );
  }
}