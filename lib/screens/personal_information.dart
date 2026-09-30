import 'package:flutter/material.dart';

class PersonalInformationPage extends StatelessWidget {
  final Map userData;

  const PersonalInformationPage({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _buildInfoTile('Username', userData['username'] ?? 'N/A'),
                SizedBox(height: 12),
                _buildInfoTile('Primary Role', userData['role'] ?? 'N/A'),
                SizedBox(height: 12),
                _buildInfoTile('Contact Number', userData['phone'] ?? 'N/A'),
                SizedBox(height: 12),
                _buildInfoTile('NID Number', userData['nid'] ?? 'N/A'),
                SizedBox(height: 12),
                _buildInfoTile('Gender', userData['gender'] ?? 'N/A'),
                SizedBox(height: 12),
                _buildInfoTile('Marital Status', userData['maritalStatus'] ?? 'N/A'),
                SizedBox(height: 12),
                _buildInfoTile('Occupation', userData['occupation'] ?? 'N/A'),
                SizedBox(height: 12),
                _buildInfoTile('Institution / Company', userData['institution'] ?? 'N/A'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}