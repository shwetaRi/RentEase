import 'package:flutter/material.dart';

class ProfileStepTwoWidget extends StatefulWidget {
  final TextEditingController occupationController;
  final TextEditingController institutionController;
  final String selectedGender;
  final ValueChanged<String> onGenderChanged;
  final String selectedMaritalStatus;
  final ValueChanged<String> onMaritalStatusChanged;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final bool isLoading;

  const ProfileStepTwoWidget(
      this.occupationController,
      this.institutionController,
      this.selectedGender,
      this.onGenderChanged,
      this.selectedMaritalStatus,
      this.onMaritalStatusChanged,
      this.onBack,
      this.onSubmit, {
        this.isLoading = false,
        super.key,
      });

  @override
  State<ProfileStepTwoWidget> createState() => _ProfileStepTwoWidgetState();
}

class _ProfileStepTwoWidgetState extends State<ProfileStepTwoWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        children: [
          const Text(
            'Personal Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Provide background details to complete your profile.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          DropdownButtonFormField<String>(
            initialValue: widget.selectedGender,
            decoration: _inputDecoration('Gender'),
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (val) {
              if (val != null) widget.onGenderChanged(val);
            },
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: widget.selectedMaritalStatus,
            decoration: _inputDecoration('Marital Status'),
            items: const [
              DropdownMenuItem(value: 'Single', child: Text('Single')),
              DropdownMenuItem(value: 'Married', child: Text('Married')),
            ],
            onChanged: (val) {
              if (val != null) widget.onMaritalStatusChanged(val);
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: widget.occupationController,
            decoration: _inputDecoration('Occupation'),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Please enter your occupation';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: widget.institutionController,
            decoration: _inputDecoration('Institution / Company'),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Please enter current Institution';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          //Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE86B42)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: widget.isLoading ? null : widget.onBack,
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE86B42),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE86B42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: widget.isLoading
                        ? null
                        : () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        widget.onSubmit();
                      }
                    },
                    child: widget.isLoading
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      'Complete',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE86B42)),
      ),
    );
  }
}