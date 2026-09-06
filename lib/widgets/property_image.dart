import 'package:flutter/material.dart';

class PropertyImage extends StatelessWidget {
  final AssetImage image;
  final String label;

  const PropertyImage({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: image,
            height: 61,
            width: 90,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 11),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ),
      ],
    );
  }
}