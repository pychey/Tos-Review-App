import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class MeduimButton extends StatelessWidget {
  final String name;
  final VoidCallback onPress;
  final Color bgColor;
  final Color textColor;
  const MeduimButton({super.key, required this.name, required this.onPress, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor
        ),
        child: Text(name, textAlign: TextAlign.center, style: TosReviewTextStyles.button.copyWith(color: textColor)),
      ),
    );
  }
}