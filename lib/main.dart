import 'package:flutter/material.dart';
import 'package:project_rent_ease/screens/home_page.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const RentEase());
}

class RentEase extends StatelessWidget {
  const RentEase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}