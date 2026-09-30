import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  final MapController _mapController = MapController();
  LatLng _currentCenter = const LatLng(23.7639, 90.4311); // Centered at Banasree/Dhaka
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // OpenStreetMap Layer
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentCenter,
                initialZoom: 16.0,
                onPositionChanged: (position, hasGesture) {
                  if (position.center != null) {
                    _currentCenter = position.center!;
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.rentease.app',
                ),
              ],
            ),

            // Fixed Center Marker Pin
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 48,
                ),
              ),
            ),

            // Top Bar Search Box
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search area..',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom "SET LOCATION" Button
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Returns latitude and longitude string back to LocationContactPage
                    String selectedCoordinates =
                        '${_currentCenter.latitude.toStringAsFixed(5)}, ${_currentCenter.longitude.toStringAsFixed(5)}';
                    Navigator.pop(context, selectedCoordinates);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A3E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SET LOCATION',
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
      ),
    );
  }
}