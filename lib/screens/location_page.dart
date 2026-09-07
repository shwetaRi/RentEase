import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? selectedDivision;
  String? selectedDistrict;
  String? selectedArea;


  final List<String> divisions = [
    'Dhaka',
    'Chattogram',
    'Rajshahi',
    'Khulna',
    'Barishal',
    'Sylhet',
    'Rangpur',
    'Mymensingh',
  ];

  final List<String> districts = [
    'Dhaka',
    'Gazipur',
    'Narayanganj',
    'Tangail',
    'Chattogram',
    'Cumilla',
    'Noakhali',
    'Rajshahi',
    'Khulna',
    'Sylhet',
  ];

  // 4 Areas
  final List<String> areas = [
    'Dhanmondi',
    'Badda',
    'Mirpur',
    'Banani',
  ];

  void resetLocation() {
    setState(() {
      selectedDivision = null;
      selectedDistrict = null;
      selectedArea = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool divisionSelected = selectedDivision != null;
    final bool districtSelected = selectedDistrict != null;
    final bool areaSelected = selectedArea != null;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9FD),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9FD),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Select area',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        actions: [
          TextButton(
            onPressed: resetLocation,
            child: const Text(
              'RESET',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 28,
        ),

        child: Column(
          children: [


            _buildDropdown(
              hint: 'Division',
              value: selectedDivision,
              items: divisions,
              enabled: true,

              onChanged: (value) {
                setState(() {
                  selectedDivision = value;


                  selectedDistrict = null;
                  selectedArea = null;
                });
              },
            ),

            const SizedBox(height: 40),

            _buildDropdown(
              hint: 'District',
              value: selectedDistrict,
              items: districts,
              enabled: divisionSelected,

              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;

                  selectedArea = null;
                });
              },
            ),

            const SizedBox(height: 40),


            _buildDropdown(
              hint: 'Area',
              value: selectedArea,
              items: areas,
              enabled: districtSelected,

              onChanged: (value) {
                setState(() {
                  selectedArea = value;
                });
              },
            ),

            const SizedBox(height: 40),


            SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton(
                onPressed: areaSelected
                    ? () {

                  Navigator.pop(
                    context,
                    selectedArea,
                  );
                }
                    : null,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9834D),
                  disabledBackgroundColor: const Color(0xFFE0D8D5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                child: const Text(
                  'Show Property',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required bool enabled,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        border: Border.all(
          color: enabled
              ? const Color(0xFF9A9599)
              : const Color(0xFFD8D3D6),
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),

      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 28,
          ),

          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 18,
              color: enabled
                  ? const Color(0xFF555158)
                  : const Color(0xFFB8B2B6),
            ),
          ),

          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),

          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}