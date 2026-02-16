import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../actions/button.dart';

class SplashBottomInfo extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final String subTitle;
  const SplashBottomInfo({super.key, required this.title, required this.onPress, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TosReviewSpacings.radiusLarge),
          topRight: Radius.circular(TosReviewSpacings.radiusLarge)
        ),
        color: TosReviewColors.greyLight,
        boxShadow: [
          BoxShadow(
            color: TosReviewColors.greyDark, 
            blurRadius: 10,   
            spreadRadius: 0, 
            offset: Offset(0, 4), 
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: TosReviewTextStyles.heading,),
          const SizedBox(height: TosReviewSpacings.m),
          Text(subTitle, style: TosReviewTextStyles.small.copyWith(color: TosReviewColors.greyDark), textAlign: TextAlign.center),
          const SizedBox(height: TosReviewSpacings.xxl),
          CustomButton(onPress: onPress, name: "Next",),
          const SizedBox(height: TosReviewSpacings.l)
        ],
      ),
    );
  }
}