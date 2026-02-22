import 'package:client/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                child: Image.asset(
                  "assets/images/home/product1.png",
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.15),
                  colorBlendMode: BlendMode.hardLight, 
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Icon(Icons.link, color: Colors.white, size: 30,),
            ),
            Positioned(
              top: 60,
              right: 20,
              child: Column(
                children: [
                  Icon(Icons.star, size: 30, color: Colors.yellow),
                  Text("4.5", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Positioned(
              top: 120,
              right: 20,
              child: Column(
                children: [
                  Icon(Icons.favorite, size: 30, color: Colors.red),
                  Text("45", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}