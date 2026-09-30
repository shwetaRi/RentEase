import 'package:flutter/material.dart';

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

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _roadController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  String? _selectedCoordinates;
  bool showError = false;
  @override
  void dispose() {

    _descriptionController.dispose();
    _sectorController.dispose();
    _roadController.dispose();
    _houseController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
