import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String name;
  final bool isSelected;

  const Category({
    super.key,
    required this.name,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      alignment: Alignment.center,
      height: 36,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF202020) : Color(0xFFF7F4F3),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(name,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color : isSelected ? Colors.white : Color(0xFF383838),
          ),
        ),
      ),
    );
  }
}
