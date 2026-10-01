import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_rent_ease/screens/property_details_page.dart'; // Adjust path to match your folder structure

class RentCard extends StatefulWidget {
  final String title;
  final String location;
  final int amount;
  final String imagePath;
  final Map<String, dynamic>? propertyData;

  const RentCard({
    super.key,
    required this.title,
    required this.location,
    required this.amount,
    required this.imagePath,
    this.propertyData
  });

  @override
  State<RentCard> createState() => _RentCardState();
}

class _RentCardState extends State<RentCard> {
  Widget _buildCardThumbnail() {
    List<dynamic>? images = widget.propertyData?['images'];

    if (images != null && images.isNotEmpty) {
      String path = images.first.toString();
      if (path.startsWith('http://') || path.startsWith('https://')) {
        return Image.network(path, fit: BoxFit.cover);
      } else if (path.startsWith('assets/')) {
        return Image.asset(path, fit: BoxFit.cover);
      } else {
        return Image.file(File(path), fit: BoxFit.cover);
      }
    }

    if (widget.imagePath.startsWith('http://') || widget.imagePath.startsWith('https://')) {
      return Image.network(widget.imagePath, fit: BoxFit.cover);
    } else if (widget.imagePath.startsWith('assets/')) {
      return Image.asset(widget.imagePath, fit: BoxFit.cover);
    } else {
      return Image.file(File(widget.imagePath), fit: BoxFit.cover);
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(
              propertyData: widget.propertyData ?? {
                'category': widget.title,
                'fullAddress': widget.location,
                'rentPrice': widget.amount.toString(),
                'images': widget.imagePath.isNotEmpty ? [widget.imagePath] : [],
              },
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 156,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: _buildCardThumbnail(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF494949),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Image(
                        image: AssetImage('assets/icons/location.png'),
                        height: 14,
                        width: 14,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.location,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF848D84),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '৳',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF9834D),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        NumberFormat('#,##,##0', 'en_IN').format(widget.amount),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF383838),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}