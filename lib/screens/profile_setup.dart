import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/profile_first.dart';
import '../widgets/profile_second.dart';
import 'home_page.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String? selectedRole;

  const ProfileSetupScreen({
    super.key,
    this.selectedRole,
  });

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isLoading = false;

  late String _selectedRole;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  String _selectedGender = 'Male';
  String _selectedMaritalStatus = 'Single';

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.selectedRole ?? 'Tenant';
  }

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

  Future<void> _handleProfileSubmit() async {
    debugPrint('Complete Button Tapped');

    final User? currentUser = FirebaseAuth.instance.currentUser;
    debugPrint('Current User: ${currentUser?.uid}');

    if (currentUser == null) {
      debugPrint('[ERROR] User is NULL! Aborting submit. ');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: No active user session.')),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      debugPrint('Writing to Firestore');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'fullName': _usernameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'nidNumber': _nidController.text.trim(),
        'role': _selectedRole,
        'gender': _selectedGender,
        'maritalStatus': _selectedMaritalStatus,
        'occupation': _occupationController.text.trim(),
        'institution': _institutionController.text.trim(),
        'isProfileComplete': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      debugPrint('Firestore Write Successful');

      if (!mounted) {
        debugPrint('Widget is no longer mounted');
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile setup completed!')),
      );

      debugPrint('Executing Navigation to HomePage');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
            (route) => false,
      );

      debugPrint('Navigation Command Sent');

    } catch (e, stackTrace) {
      debugPrint('Navigation error $e');
      debugPrint(stackTrace.toString());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile Setup',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: _currentStep > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: _previousPage,
        )
            : null,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _currentStep = index);
        },
        children: [
          ProfileStepOneWidget(
            usernameController: _usernameController,
            phoneController: _phoneController,
            nidController: _nidController,
            selectedRole: _selectedRole,
            onRoleChanged: (val) => setState(() => _selectedRole = val),
            onNext: _nextPage,
          ),
          ProfileStepTwoWidget(
            _occupationController,
            _institutionController,
            _selectedGender,
                (val) => setState(() => _selectedGender = val),
            _selectedMaritalStatus,
                (val) => setState(() => _selectedMaritalStatus = val),
            _previousPage,
            _handleProfileSubmit,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}