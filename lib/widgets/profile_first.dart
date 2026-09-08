import 'package:flutter/material.dart';

class ProfileStepOneWidget extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController nidController;
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;
  final VoidCallback onNext;

  const ProfileStepOneWidget(
      this.usernameController,
      this.phoneController,
      this.nidController,
      this.selectedRole,
      this.onRoleChanged,
      this.onNext, {
        super.key,
      });

  @override
  State<ProfileStepOneWidget> createState() => _ProfileStepOneWidgetState();
}

class _ProfileStepOneWidgetState extends State<ProfileStepOneWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        children: [
          const Text(
            'Account Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Enter your basic details to get started.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          // Username
          TextFormField(
            controller: widget.usernameController,
            decoration: _inputDecoration('Username'),
            validator: (val) {
              if(val == null || val.isEmpty){
                return 'Please enter a username' ;
              } else{
                return null;
              }
            },
          ),
          const SizedBox(height: 16),

          // Primary Role
          DropdownButtonFormField<String>(
            initialValue: widget.selectedRole,
            decoration: _inputDecoration('Primary Role'),
            items: const [
              DropdownMenuItem(value: 'Tenant', child: Text('Tenant')),
              DropdownMenuItem(value: 'Landlord', child: Text('Landlord')),
            ],
            onChanged: (val) {
              if (val != null) widget.onRoleChanged(val);
            },
          ),
          const SizedBox(height: 16),

          // Contact Number
          TextFormField(
            controller: widget.phoneController,
            keyboardType: TextInputType.phone,
            decoration:
            _inputDecoration('Contact Number'),
            validator: (val) {
              if(val == null || val.isEmpty){
                return 'Please enter your phone number' ;
              } else{
                return null;
              }
            }
          ),
          const SizedBox(height: 16),

          // NID Number
          TextFormField(
            controller: widget.nidController,
            keyboardType: TextInputType.number,
            decoration:
            _inputDecoration('NID Number'),
            validator: (val) {
              if(val == null || val.isEmpty){
                return 'Please enter your NID number' ;
              } else{
                return null;
              }
            }
          ),
          const SizedBox(height: 32),

          // Next Button
          SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE86B42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onNext();
                }
              },
              child: const Text(
                'Next Step',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
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