import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_rent_ease/widgets/property_details.dart';
import 'package:project_rent_ease/screens/login_page.dart';
import 'package:project_rent_ease/screens/dashboard_page.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? propertyData;

  const PropertyDetailsPage({
    super.key,
    this.propertyData,
  });

  @override
  State<PropertyDetailsPage> createState() => _PropertyState();
}

class _PropertyState extends State<PropertyDetailsPage> {
  bool isFavourite = false;
  bool _isBooking = false;

  Future<void> _handleBookNow() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return;
    }

    setState(() {
      _isBooking = true;
    });

    try {
      // 1. Save application record to Firestore
      await FirebaseFirestore.instance.collection('bookings').add({
        'applicantId': user.uid,
        'applicantEmail': user.email ?? '',
        'propertyData': widget.propertyData ?? {},
        'status': 'Pending',
        'appliedAt': DateTime.now().toIso8601String(),
      });

      // 2. 1-second delay
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      setState(() {
        _isBooking = false;
      });

      // 3. Navigate immediately to DashboardPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isBooking = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book property: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildImageWidget(
      String path, {
        double? width,
        double? height,
        BoxFit fit = BoxFit.cover,
      }) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    } else if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Image.file(
        File(path),
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String category = widget.propertyData?['category'] ?? 'Flat';
    final String title = '$category Rent Home';

    final String address = widget.propertyData?['fullAddress'] ??
        widget.propertyData?['area'] ??
        "Road # 12, Block G, Dhanmondi";

    final String rentPrice = widget.propertyData?['rentPrice'] != null
        ? 'TK ${widget.propertyData!['rentPrice']}'
        : 'TK 15,000';

    final String rentPeriod = widget.propertyData?['rentPeriod'] != null
        ? '/ ${widget.propertyData!['rentPeriod']}'
        : '/ month';

    final String rooms = widget.propertyData?['rooms']?.toString() ?? '0';
    final String bathrooms = widget.propertyData?['bathrooms']?.toString() ?? '0';
    final String areaSqFt = widget.propertyData?['squareFeet'] != null &&
        widget.propertyData!['squareFeet'].toString().isNotEmpty
        ? widget.propertyData!['squareFeet'].toString()
        : '0';

    final List<dynamic> imagePaths =
        (widget.propertyData?['images'] as List<dynamic>?) ?? [];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  imagePaths.isNotEmpty
                      ? _buildImageWidget(
                    imagePaths.first.toString(),
                    width: double.infinity,
                    height: 436,
                    fit: BoxFit.cover,
                  )
                      : const Image(
                    image: AssetImage('assets/images/card_image_4.png'),
                    width: double.infinity,
                    height: 436,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                        child: Container(
                          height: 62,
                          width: 62,
                          decoration: const BoxDecoration(
                            color: Color(0x33000000),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),

              // Title and Location Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 23,
                                color: Color(0xFF000000),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  address,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                      },
                      child: Container(
                        width: 33,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isFavourite ? Colors.red.shade50 : Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: isFavourite ? Colors.red : Colors.grey.shade600,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Photos Section Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Photos',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'See More',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (imagePaths.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: SizedBox(
                          height: 75,
                          child: Row(
                            children: imagePaths.map((path) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _buildImageWidget(
                                      path.toString(),
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                    const SizedBox(height: 10),

                    // Dynamic Property Specs
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Property Details',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See More',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PropertyDetails.bedrooms(value: rooms),
                            PropertyDetails.bathrooms(value: bathrooms),
                            PropertyDetails.area(value: areaSqFt),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
          child: Container(
            height: 71,
            decoration: BoxDecoration(
              color: const Color(0xFF0F0804),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '$rentPrice $rentPeriod',
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF073CFE),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: _isBooking ? null : _handleBookNow,
                  child: _isBooking
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}