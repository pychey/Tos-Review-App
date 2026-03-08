import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class NotificationTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String duration;
  final VoidCallback onPress;
  const NotificationTile({
    super.key, required this.imagePath, required this.title, required this.date, required this.duration, required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
              child: Image.asset(
                imagePath, 
                fit: BoxFit.cover,
                width: 100,
                height: 100, 
              ),
            ),
            const SizedBox(width: TosReviewSpacings.m),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TosReviewTextStyles.button.copyWith(fontWeight: FontWeight.bold),),
                    Text(date, style: TosReviewTextStyles.body,)
                  ],
                ),
              ),
            ),
            Text(duration, style: TosReviewTextStyles.body,),
            Align(
              alignment: Alignment.topCenter,
              child: Icon(Icons.more_vert)
            )
          ],
        ),
      ),
    );
  }
}