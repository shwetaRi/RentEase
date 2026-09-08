import 'package:flutter/material.dart';

class PropertyDetails extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;

  const PropertyDetails({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });


  const PropertyDetails.bedrooms({
    super.key,
    required this.value,
  })  : icon = Icons.king_bed_outlined,
        title = 'Bedrooms';

  // Fixed Named Constructor for Bathrooms
  const PropertyDetails.bathrooms({
    super.key,
    required this.value,
  })  : icon = Icons.bathtub_outlined,
        title = 'Bathrooms';

  // Fixed Named Constructor for Area
  const PropertyDetails.area({
    super.key,
    required this.value,
  })  : icon = Icons.crop_square_outlined,
        title = 'Area (in sqft)';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: const Color(0xFF000000),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}