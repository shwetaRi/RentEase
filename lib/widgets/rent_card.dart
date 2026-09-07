import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RentCard extends StatefulWidget {
  final String title;
  final String location;
  final int amount;
  final String imagePath;

  const RentCard({
    super.key,
    required this.title,
    required this.location,
    required this.amount,
    required this.imagePath,
  });

  @override
  State<RentCard> createState() => _RentCardState();
}

class _RentCardState extends State<RentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 156,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Text(widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF494949),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Image(image: AssetImage('assets/icons/location.png'), height: 14, width: 14,),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(widget.location,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF848D84),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('৳',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF9834D),
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(NumberFormat('#,##,##0', 'en_IN').format(widget.amount),
                        style: TextStyle(
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
          ),
        ],
      ),
    );
  }
}
