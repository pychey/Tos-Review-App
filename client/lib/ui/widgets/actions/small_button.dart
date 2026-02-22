import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onPress;
  final String name;
  final double? width;
  final IconData? icon;
  final bool isActive;
  const SmallButton({super.key, required this.onPress, required this.name, this.icon, this.width, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          width: width??100,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isActive ? TosReviewColors.primary : TosReviewColors.greyDark
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white)),
              if(icon != null) ...[
                const SizedBox(width: 5),
                Icon(icon, size: 15, color: Colors.white,)
              ]
            ],
          ),
        ),
      );
  }
}