import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ReviewPost extends StatelessWidget {
  final VoidCallback onPress;
  const ReviewPost({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
            child: Image.asset(
              "assets/images/home/product1.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.15),
              colorBlendMode: BlendMode.hardLight, 
            ),
          ),
          
          Positioned(
            top: 10,
            right: 10,
            child: Column(
              children: [
                Icon(Icons.star, size: 25, color: Colors.yellow),
                Text("4.5", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/home/profile.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(width: 2,),
                Expanded(
                  child: Text("Leng Menghan", style: TosReviewTextStyles.tooSmall.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),),
                ),
                TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                  backgroundColor: TosReviewColors.greyLight,
                  padding: const EdgeInsets.all(5),       // small padding
                  minimumSize: Size.zero, 
                ),
                child: Text(
                  "Follow", 
                  style: TosReviewTextStyles.tooSmall.copyWith(color: TosReviewColors.primary, fontWeight: FontWeight.bold))
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
