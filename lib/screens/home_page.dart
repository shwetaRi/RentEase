import 'package:flutter/material.dart';
import 'package:project_rent_ease/widgets/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profileImagePath = 'assets/images/profile.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: AssetImage('assets/images/logo.png'), width: 150),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(profileImagePath),
                            fit: BoxFit.cover,
                        ),
                        color: Color(0xFFE6DBD7),
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('Discover verified homes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF383838),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Color(0xFFE1E1E1),
                    width: 1,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Image(image: AssetImage('assets/icons/search.png'), height: 20, width: 20),
                      SizedBox(width: 8),
                      Text('Search home rents near you...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA0A0A0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Category(name: 'Mirpur', isSelected: false),
                    Category(name: 'Dhanmondi', isSelected: true),
                    Category(name: 'Banani', isSelected: false),
                    Category(name: 'Gulshan', isSelected: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
