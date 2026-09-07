import 'package:flutter/material.dart';

class ProfileStepTwoWidget extends StatefulWidget {
  final TextEditingController dobController;
  final TextEditingController occupationController;
  final TextEditingController institutionController;
  final String selectedGender;
  final ValueChanged<String> onGenderChanged;
  final String selectedMaritalStatus;
  final ValueChanged<String> onMaritalStatusChanged;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  // Positional constructor—clean and simple!
  const ProfileStepTwoWidget(
      this.dobController,
      this.occupationController,
      this.institutionController,
      this.selectedGender,
      this.onGenderChanged,
      this.selectedMaritalStatus,
      this.onMaritalStatusChanged,
      this.onBack,
      this.onSubmit, {
        super.key,
      });

  @override
  State<ProfileStepTwoWidget> createState() => _ProfileStepTwoWidgetState();
}

class _ProfileStepTwoWidgetState extends State<ProfileStepTwoWidget> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE86B42),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      widget.dobController.text =
      "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

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
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Provide background details to complete your profile.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          // Date of Birth
          TextFormField(
            controller: widget.dobController,
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: _inputDecoration(
                'Date of Birth', Icons.calendar_today_outlined),
            validator: (val) => val == null || val.isEmpty
                ? 'Please select your Date of Birth'
                : null,
          ),
          const SizedBox(height: 16),

          // Gender
          DropdownButtonFormField<String>(
            value: widget.selectedGender,
            decoration: _inputDecoration('Gender', Icons.wc_outlined),
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

          // Marital Status
          DropdownButtonFormField<String>(
            initialValue: widget.selectedMaritalStatus,
            decoration:
            _inputDecoration('Marital Status', Icons.favorite_outline),
            items: const [
              DropdownMenuItem(value: 'Single', child: Text('Single')),
              DropdownMenuItem(value: 'Married', child: Text('Married')),
            ],
            onChanged: (val) {
              if (val != null) widget.onMaritalStatusChanged(val);
            },
          ),
          const SizedBox(height: 16),

          // Occupation
          TextFormField(
            controller: widget.occupationController,
            decoration: _inputDecoration('Occupation', Icons.work_outline),
            validator: (val) => val == null || val.isEmpty
                ? 'Please enter your occupation'
                : null,
          ),
          const SizedBox(height: 16),

          // Institution / Company
          TextFormField(
            controller: widget.institutionController,
            decoration: _inputDecoration(
                'Institution / Company', Icons.business_outlined),
            validator: (val) => val == null || val.isEmpty
                ? 'Please enter institution/company'
                : null,
          ),
          const SizedBox(height: 32),

          // Buttons Row
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
                    onPressed: widget.onBack,
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit();
                      }
                    },
                    child: const Text(
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

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey.shade600),
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