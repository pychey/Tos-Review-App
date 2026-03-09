import 'package:flutter/material.dart';

class ButtonDeleteProfile extends StatelessWidget {
  final VoidCallback onPress;
  const ButtonDeleteProfile({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}