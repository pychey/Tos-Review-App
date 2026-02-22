import 'package:client/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  final ValueChanged<int> onClick;
  const Rating({super.key, required this.onClick});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _rate = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [1, 2, 3, 4, 5].map((i) => 
          GestureDetector(
            onTap: () => {
              setState(() {
                _rate == i ? _rate = 0 : _rate = i;
              }),
              widget.onClick(_rate),
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(Icons.star, color: i <= _rate ? Colors.amber : TosReviewColors.greyDark,),
            )
        ),
      ).toList(),
    );
  }
}