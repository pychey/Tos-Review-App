import 'package:client/ui/screens/splash/register.dart';
import 'package:client/ui/widgets/displays/splash_bottom_info.dart';
import 'package:flutter/material.dart';

import 'widget/custom_app_bar.dart';

class Splash3 extends StatelessWidget {
  const Splash3({super.key});
  void onNext(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
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
    return Stack(
      children: [
        Positioned(
          top: 110,
          left: 0,
          right: 0,
          child: Image.asset('assets/images/splash/posts.png')
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 1.0], 
              colors: [Color.fromARGB(255, 196, 230, 226), Colors.transparent],
            ),
          ),
                ),
        ),
      ],
    );
  }

  Widget mainWidget(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SplashBottomInfo(
          title: "Discover the best product", 
          onPress: () => onNext(context), 
          subTitle: "Get unbiased product reviews and ratings from real customers. Make informed decisions with detailed comparisons and expert analysis.")
      ],
    );
  }
}