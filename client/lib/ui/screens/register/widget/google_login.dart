import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class GoogleLogin extends StatelessWidget {
  final VoidCallback onPress;
  const GoogleLogin({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 12, 0, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Row(
          children: [
            Image.asset('assets/images/register/google.png', height: 30,),
            const SizedBox(width: 10),
            Text("Continure with Google", style: TosReviewTextStyles.body,),
          ],
        ),
      ),
    );
  }
}