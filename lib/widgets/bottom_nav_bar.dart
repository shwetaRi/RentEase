import 'package:flutter/material.dart';
import 'package:project_rent_ease/screens/dashboard_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

     BottomNavBar({
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
            onTap: () {
              onTap(1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardPage(),
                ),
              );
            },
            child: Icon(
              currentIndex == 1 ? Icons.dashboard : Icons.dashboard_outlined,
              size: 24,
              color: currentIndex == 1 ? const Color(0xFFF9834D) : Colors.grey,
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
