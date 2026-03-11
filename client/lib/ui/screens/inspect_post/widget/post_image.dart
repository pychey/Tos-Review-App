import 'package:client/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:client/data/models/post.dart';

class PostImage extends StatelessWidget {
  final Post post;
  final bool isLiked;
  const PostImage({super.key, required this.post, required this.isLiked});

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
                child: post.mediaUrls.isNotEmpty
                ? Image.network(post.mediaUrls[0], fit: BoxFit.cover, color: Colors.black.withOpacity(0.15), colorBlendMode: BlendMode.hardLight)
                : Image.asset(
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
                  Text(post.avgUserRating?.toStringAsFixed(1) ?? post.authorRating.toStringAsFixed(1), style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Positioned(
              top: 120,
              right: 20,
              child: Column(
                children: [
                  Icon(Icons.favorite, size: 30, color: Colors.red),
                  Text('${post.count.likes}', style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}