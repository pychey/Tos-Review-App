import 'package:flutter/material.dart';

class ChooseImageButton extends StatelessWidget {
  final VoidCallback onPress;
  const ChooseImageButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.black54,
        ),
      ),
    );
  }
}