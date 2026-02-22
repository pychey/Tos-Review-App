import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

AppBar customAppBar(VoidCallback onPress){
  return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          GestureDetector(
            onTap: onPress,
            child: Text("Skip", style: TosReviewTextStyles.body,)
          )
        ],
      ),
    );
}