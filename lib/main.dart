import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_rent_ease/screens/dashboard_page.dart';
import 'package:project_rent_ease/screens/home_page.dart';
import 'package:project_rent_ease/screens/property_details_page.dart';
import 'package:project_rent_ease/screens/signUp.dart';
import 'screens/login_page.dart';
import 'firebase_options.dart';
import 'screens/property_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const SignUpScreen(),
    );
  }
}