import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostImgPreview extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final XFile image;
  const CreatePostImgPreview({super.key, required this.image, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onEdit,
          child: Container(
            width: 200,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 7,
          right: 15,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}