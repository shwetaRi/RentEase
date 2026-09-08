import 'package:flutter/material.dart';
import 'package:project_rent_ease/screens/dashboard_page.dart';
import 'package:project_rent_ease/screens/home_page.dart';
import 'package:project_rent_ease/screens/profile_setup.dart';
import 'package:project_rent_ease/screens/profile_view.dart';
import 'package:project_rent_ease/screens/property_details_page.dart';
import 'package:project_rent_ease/screens/signUp.dart';
import 'screens/login_page.dart';
import 'screens/signUp.dart';
import 'screens/property_details_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/profile_view.dart';

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
      home: const DashboardPage(),
    );
  }
}