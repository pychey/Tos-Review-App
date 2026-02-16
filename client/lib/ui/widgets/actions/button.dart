import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String name;
  final bool isLong;
  final bool isRoundBorderRaduis;
  final Color? backgroundColor;
  final Color? textColor;
  const CustomButton({super.key, required this.onPress, required this.name, this.isLong = false, this.isRoundBorderRaduis = true, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: isLong ? double.infinity : 200,
        decoration: BoxDecoration(
          gradient: backgroundColor == null ? LinearGradient(
            colors: TosReviewColors.gradientButton
          ) : null,
          color: backgroundColor,
          borderRadius: isRoundBorderRaduis? BorderRadius.circular(50) : BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: onPress, 
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: textColor ?? TosReviewColors.white
          ),
          child: Text(name, style: TosReviewTextStyles.button)
        ),
      ),
    );
  }
}