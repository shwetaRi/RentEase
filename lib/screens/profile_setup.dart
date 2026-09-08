import 'package:flutter/material.dart';
import '../widgets/profile_first.dart';
import '../widgets/profile_second.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nidController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();

  // Dropdowns
  String selectedRole = 'Tenant';
  String selectedGender = 'Male';
  String selectedMaritalStatus = 'Single';

  @override
  void dispose() {
    _pageController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    nidController.dispose();
    dobController.dispose();
    occupationController.dispose();
    institutionController.dispose();
    super.dispose();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void submitProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile setup completed successfully!'),
        backgroundColor: Color(0xFFE86B42),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          'Profile Setup',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildProgressStep(
                    stepNumber: 1,
                    title: 'Account',
                    isActive: _currentStep >= 0,
                  ),
                ),
                Container(
                  width: 32,
                  height: 2,
                  color: _currentStep >= 1
                      ? const Color(0xFFE86B42)
                      : Colors.grey.shade200,
                ),
                Expanded(
                  child: _buildProgressStep(
                    stepNumber: 2,
                    title: 'Personal',
                    isActive: _currentStep >= 1,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => setState(() => _currentStep = index),
              children: [
                ProfileStepOneWidget(
                  usernameController,
                  phoneController,
                  nidController,
                  selectedRole,
                      (val) => setState(() => selectedRole = val),
                  nextPage,
                ),
                ProfileStepTwoWidget(
                  occupationController,
                  institutionController,
                  selectedGender,
                      (val) => setState(() => selectedGender = val),
                  selectedMaritalStatus,
                      (val) => setState(() => selectedMaritalStatus = val),
                  previousPage,
                  submitProfile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep({
     required int stepNumber,
     required String title,
     required bool isActive,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor:
          isActive ? const Color(0xFFE86B42) : Colors.grey.shade300,
          child: Text(
            '$stepNumber',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black87 : Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}