import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: const Color(0xFFF0E3E7),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          GestureDetector(
            onTap: () => onTap(0),
            child: Image(
              image: AssetImage(
                currentIndex == 0
                    ? 'assets/icons/home_selected.png'
                    : 'assets/icons/home.png',
              ),
              height: 24,
              width: 24,
            ),
          ),

          GestureDetector(
            onTap: () => onTap(1),
            child: Image(
              image: AssetImage(
                currentIndex == 1
                    ? 'assets/icons/search_selected.png'
                    : 'assets/icons/search.png',
              ),
              height: 24,
              width: 24,
            ),
          ),

          GestureDetector(
            onTap: () => onTap(2),
            child: Image(
              image: AssetImage(
                currentIndex == 2
                    ? 'assets/icons/love_selected.png'
                    : 'assets/icons/love.png',
              ),
              height: 24,
              width: 24,
            ),
          ),

          GestureDetector(
            onTap: () => onTap(3),
            child: Image(
              image: AssetImage(
                currentIndex == 3
                    ? 'assets/icons/profile_selected.png'
                    : 'assets/icons/profile.png',
              ),
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
