import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_rent_ease/screens/home_page.dart';
import '../widgets/profile_first.dart';
import '../widgets/profile_second.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  // Explicitly initialize PageController to 0 so it always starts at Step 1
  final PageController _pageController = PageController(initialPage: 0);

  // Step 1 Controllers & State
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  String _selectedRole = 'Tenant';

  // Step 2 Controllers & State
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  String _selectedGender = 'Male';
  String _selectedMaritalStatus = 'Single';

  bool _isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _nidController.dispose();
    _occupationController.dispose();
    _institutionController.dispose();
    super.dispose();
  }

  // Move from Step 1 to Step 2
  void _goToStepTwo() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Move from Step 2 back to Step 1
  void _goToStepOne() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Complete Profile Setup & Submit to Firestore
  Future<void> _handleProfileSubmit() async {
    setState(() => _isLoading = true);

    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception("User session not found. Please log in again.");
      }

      // Save combined data from Step 1 and Step 2 into Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'username': _usernameController.text.trim(),
        'role': _selectedRole,
        'phone': _phoneController.text.trim(),
        'nid': _nidController.text.trim(),
        'gender': _selectedGender,
        'maritalStatus': _selectedMaritalStatus,
        'occupation': _occupationController.text.trim(),
        'institution': _institutionController.text.trim(),
        'profileCompleted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Asynchronous context safety check
      if (!mounted) return;

      // Navigate to Home/MainShellPage and clear entire route stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(), // Replace with MainShellPage()
        ),
            (route) => false,
      );
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Failed to save profile details."),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Always reset loading indicator if navigation didn't take place
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
        elevation: 0,
        automaticallyImplyLeading: false, // Disables top back button to prevent escaping setup
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disables manual swiping
        children: [
          // Step 1 Widget
          ProfileStepOneWidget(
            usernameController: _usernameController,
            phoneController: _phoneController,
            nidController: _nidController,
            selectedRole: _selectedRole,
            onRoleChanged: (val) => setState(() => _selectedRole = val),
            onNext: _goToStepTwo,
          ),

          // Step 2 Widget
          ProfileStepTwoWidget(
            _occupationController,
            _institutionController,
            _selectedGender,
                (val) => setState(() => _selectedGender = val),
            _selectedMaritalStatus,
                (val) => setState(() => _selectedMaritalStatus = val),
            _goToStepOne,          // Back button callback
            _handleProfileSubmit, // Complete button callback
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
