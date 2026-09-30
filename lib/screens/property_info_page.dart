import 'package:flutter/material.dart';
import 'package:project_rent_ease/widgets/property_counter.dart';
import 'package:project_rent_ease/screens/home_page.dart';
import 'package:project_rent_ease/screens/location_contact_page.dart';
class PropertyInfoPage extends StatefulWidget {
  final String selectedCategory; // Stores 'Family', 'Office', etc.

  const PropertyInfoPage({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<PropertyInfoPage> createState() => _PropertyInfoPageState();
}

class _PropertyInfoPageState extends State<PropertyInfoPage> {
  int roomTotal = 0;
  int bathrooms = 0;
  int balcony = 0;
  String? selectedPeriod;
  bool showError = false;

  final TextEditingController _floorLevelController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _rentPriceController = TextEditingController();

  final List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  void dispose() {
    _sizeController.dispose();
    _floorLevelController.dispose();
    _rentPriceController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    bool isInvalid = roomTotal == 0 ||
        _floorLevelController.text.trim().isEmpty ||
        _rentPriceController.text.trim().isEmpty ||
        selectedPeriod == null;

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
      Map<String, dynamic> propertyData = {
        'category': widget.selectedCategory,
        'rooms': roomTotal,
        'bathrooms': bathrooms,
        'balcony': balcony,
        'floorLevel': _floorLevelController.text.trim(),
        'squareFeet': _sizeController.text.trim(),
        'rentPrice': _rentPriceController.text.trim(),
        'rentPeriod': selectedPeriod,
      };

      debugPrint("Property Data Collected: $propertyData");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Property Information',
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
                                    color: Color(0xFF90EE90),
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
                                    color: Color(0xFF808080),
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
                          const SizedBox(height: 48),
                          PropertyCounter(
                            label: 'No. of Rooms',
                            value: roomTotal,
                            onChanged: (val) {
                              setState(() => roomTotal = val);
                            },
                          ),
                          const SizedBox(height: 12),
                          PropertyCounter(
                            label: 'No. of Bathrooms',
                            value: bathrooms,
                            onChanged: (val) {
                              setState(() => bathrooms = val);
                            },
                          ),
                          const SizedBox(height: 12),
                          PropertyCounter(
                            label: 'No. of Balcony',
                            value: balcony,
                            onChanged: (val) {
                              setState(() => balcony = val);
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF70D6F6),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(11),
                                      topRight: Radius.circular(11),
                                    ),
                                  ),
                                  child: const Text(
                                    'Floor Level',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: TextField(
                                    controller: _floorLevelController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Floor Level (e.g. 1st Floor)',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Area in Sq.Ft. (optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _sizeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Room Size',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  ),
                                ),
                              ),
                              Container(
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBFEFFF),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Sq.Ft.',
                                  style: TextStyle(
                                    color: Color(0xFF007A9E),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Rent Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _rentPriceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Rent Price in BDT',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  ),
                                ),
                              ),
                              Container(
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBFEFFF),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'BDT',
                                  style: TextStyle(
                                    color: Color(0xFF007A9E),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Rent Period',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: periods.map((period) {
                              bool isSelected = selectedPeriod == period;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPeriod = period;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF00A3E0) : const Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF00A3E0) : const Color(0xFFE0E0E0),
                                    ),
                                  ),
                                  child: Text(
                                    period,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _validateAndSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A3E0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
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
                    child: const Row(
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
}