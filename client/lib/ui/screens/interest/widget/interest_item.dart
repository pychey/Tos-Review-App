import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class InterestItem extends StatefulWidget {
  final String itemName;
  final ValueChanged<String> onPress;
  const InterestItem({super.key, required this.itemName, required this.onPress});

  @override
  State<InterestItem> createState() => _InterestItemState();
}

class _InterestItemState extends State<InterestItem> {
  bool isSelected = false;

  double get borderWidth => isSelected ? 2 : 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected; 
        });
        widget.onPress(widget.itemName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: borderWidth),
          borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(isSelected) Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check, size: 17,)
            ),
            Text(widget.itemName, style: TosReviewTextStyles.body),
            if(!isSelected)Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(Icons.add, size: 17,)
            )
          ],
        ),
      ),
    );
  }
}