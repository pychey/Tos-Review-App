import 'package:client/ui/screens/splash/register.dart';
import 'package:client/ui/screens/splash/splash2.dart';
import '../../../ui/widgets/displays/splash_bottom_info.dart';
import 'package:flutter/material.dart';

import 'widget/custom_app_bar.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  void onNext(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Splash2()),
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
    return Center(
      child: Stack(
        children: [
          OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 1000,
                height: 700,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1.0], 
                    colors: [Colors.white, Color.fromARGB(255, 63, 135, 130)],
                  ),
                ),
              ),
            ),
          ),
          Container(
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
          ),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color.fromARGB(255, 195, 231, 219), Colors.white],
                        ),
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    child: Image.asset('assets/images/splash/girl.png', height: 300,)
                  ),
                  Positioned(
                    top: 100,
                    right: 60,
                    child: Transform.rotate(
                      angle: -0.5,
                      child: Image.asset('assets/images/splash/heart.png', height: 40, width: 40,)
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 80,
                    child: Transform.rotate(
                      angle: -0.5,
                      child: Image.asset('assets/images/splash/heart.png', height: 30, width: 30,)
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 160,
                    child: Transform.rotate(
                      angle: 0.5,
                      child: Image.asset('assets/images/splash/chart.png', height: 40, width: 40,)
                    ),
                  ),
                  Positioned(
                    top: 160,
                    right: 170,
                    child: Transform.rotate(
                      angle: 0.5,
                      child: Image.asset('assets/images/splash/chart.png', height: 30, width: 30,)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SplashBottomInfo(
          title: "Honest Review App", 
          onPress: () => onNext(context), 
          subTitle: "Read authentic product reviews from verified buyers. Compare ratings, see detailed breakdowns, and find the best products for your needs.")
      ],
    );
  }
}