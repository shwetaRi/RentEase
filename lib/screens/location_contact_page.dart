import 'package:flutter/material.dart';
import 'package:project_rent_ease/screens/location_page.dart';
import 'package:project_rent_ease/screens/map_picker_page.dart';
import 'package:project_rent_ease/screens/property_details_page.dart';

class LocationContactPage extends StatefulWidget {
  final Map<String, dynamic> propertyData;

  const LocationContactPage({
    super.key,
    required this.propertyData,
  });

  @override
  State<LocationContactPage> createState() => _LocationContactPageState();
}

class _LocationContactPageState extends State<LocationContactPage> {
  String? selectedDivision;
  String? selectedDistrict;
  String? selectedArea;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _roadController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  String? _selectedCoordinates;
  bool showError = false;
  @override
  void dispose() {
    _phoneController.dispose();
    _descriptionController.dispose();
    _sectorController.dispose();
    _roadController.dispose();
    _houseController.dispose();
    super.dispose();
  }
  void _validateAndSubmit() {
    bool isInvalid = selectedDivision == null ||
        selectedDistrict == null ||
        selectedArea == null||
        _phoneController.text.trim().isEmpty;

    if (isInvalid) {
      setState(() {
        showError = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            showError = false;
          });
        }
      });
    } else {
      String fullAddress =
          'House ${_houseController.text.trim()}, Road ${_roadController.text.trim()}, Sector ${_sectorController.text.trim()}, $selectedArea, $selectedDistrict, $selectedDivision';

      Map<String, dynamic> completePropertyData = {
        ...widget.propertyData,
        'division': selectedDivision,
        'district': selectedDistrict,
        'area': selectedArea,
        'coordinates': _selectedCoordinates ?? '',
        'phone': '+880${_phoneController.text.trim()}',
        'description': _descriptionController.text.trim(),
        'sector': _sectorController.text.trim(),
        'road': _roadController.text.trim(),
        'house': _houseController.text.trim(),
        'fullAddress': fullAddress,
      };

      debugPrint("Complete Property Data Bundle: $completePropertyData");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PropertyDetailsPage(
            propertyData: completePropertyData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool divisionSelected = selectedDivision != null;
    final bool districtSelected = selectedDistrict != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Location & Contact',

          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Wizard Step Indicators
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF006400),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF006400),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
                                    child: Text(
                                      '2',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF90EE90),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
                                    child: Text(
                                      '3',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF808080),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
                                    child: Text(
                                      '4',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 35),

                          // Division Dropdown (Using LocationPage.divisions)
                          const Text(
                            '• Select Division',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildDropdown(
                            hint: 'Division',
                            value: selectedDivision,
                            items: LocationPage.divisions,
                            enabled: true,
                            onChanged: (value) {
                              setState(() {
                                selectedDivision = value;
                                selectedDistrict = null;
                                selectedArea = null;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // District Dropdown (Using LocationPage.districts)
                          const Text(
                            '• Select District',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildDropdown(
                            hint: 'District',
                            value: selectedDistrict,
                            items: LocationPage.districts,
                            enabled: divisionSelected,
                            onChanged: (value) {
                              setState(() {
                                selectedDistrict = value;
                                selectedArea = null;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // Area Dropdown (Using LocationPage.areas)
                          const Text(
                            '• Select Area',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildDropdown(
                            hint: 'Area',
                            value: selectedArea,
                            items: LocationPage.areas,
                            enabled: districtSelected,
                            onChanged: (value) {
                              setState(() {
                                selectedArea = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),

                          // Map Set Location Card
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2FAF4),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _selectedCoordinates != null
                                            ? 'Location Set: $_selectedCoordinates'
                                            : 'Live Locations help people find easily property',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const MapPickerPage(),
                                            ),
                                          );
                                          if (result != null) {
                                            setState(() {
                                              _selectedCoordinates = result.toString();
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.location_on, size: 18, color: Colors.white),
                                        label: const Text('SET LOCATION', style: TextStyle(color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF00A3E0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.map_outlined, size: 56, color: Color(0xFF00A3E0)),
                              ],
                            ),
                          ),
                           SizedBox(height: 20),

                           Text(
                            '• Contact Number',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                           SizedBox(height: 6),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration:  InputDecoration(
                              hintText: '1XXXXXXXXX',
                              prefixText: '+880 ',
                              prefixStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                           SizedBox(height: 25),
                           Center(
                            child: Text(
                              'OPTIONAL DETAILS',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                           SizedBox(height: 15),


                           Text(
                            '• Short Description',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                           SizedBox(height: 6),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 3,
                            decoration:  InputDecoration(
                              hintText: 'Enter short description',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                           SizedBox(height: 16),

                           Text(
                            '• Sector',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                           SizedBox(height: 6),
                          TextField(
                            controller: _sectorController,
                            decoration:  InputDecoration(
                              hintText: 'e.g. Block C',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                           SizedBox(height: 16),

                           Text(
                            '• Road',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                           SizedBox(height: 6),
                          TextField(
                            controller: _roadController,
                            decoration: const InputDecoration(
                              hintText: 'e.g. Road 4',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                           SizedBox(height: 16),


                           Text(
                            '• House/Plot',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                           SizedBox(height: 6),
                          TextField(
                            controller: _houseController,
                            decoration: const InputDecoration(
                              hintText: 'e.g. House 12',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                           SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration:  BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child:  Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _validateAndSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Color(0xFF00A3E0),
                          foregroundColor: Colors.white,
                          padding:  EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:  Text(
                          'NEXT',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Incomplete Information Floating Red Banner
            if (showError)
              Positioned(
                bottom: 80,
                left: 20,
                right: 20,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red.shade600,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.white, size: 24),
                        SizedBox(width: 10),
                        Text(
                          'Incomplete Information',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(
          color: enabled ?  Color(0xFF9A9599) :  Color(0xFFD8D3D6),
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(8),
        color: enabled ? Colors.white : Colors.grey.shade100,
      ),
      padding:  EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon:  Icon(
            Icons.arrow_drop_down,
            size: 28,
          ),
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 15,
              color: enabled ?  Color(0xFF555158) :  Color(0xFFB8B2B6),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style:  TextStyle(
                  fontSize: 15,
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