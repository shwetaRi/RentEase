import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_rent_ease/screens/property_details_page.dart';


class AppliedTab extends StatelessWidget {
  const AppliedTab({super.key});

  Widget _buildCardImage(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey.shade200),
      );
    } else if (path.startsWith('assets/')) {
      return Image.asset(path, fit: BoxFit.cover);
    } else {
      return Image.file(File(path), fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(
        child: Text(
          'Please log in to view applied properties.',
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('applicantId', isEqualTo: currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE86B42)),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading applications: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];

        return ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // Active Applications Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Active Applications',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${docs.length} Homes Applied',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFFF0EC),
                    child: Icon(
                      Icons.assignment_outlined,
                      color: Color(0xFFE86B42),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (docs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'No applied properties yet.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            else
              for (var doc in docs) ...[
                Builder(
                  builder: (context) {
                    final bookingData = doc.data() as Map<String, dynamic>;
                    final property = Map<String, dynamic>.from(
                        bookingData['propertyData'] ?? {});

                    final String category = property['category'] ?? 'Flat';
                    final String title = '$category Rent Home';
                    final String location = property['fullAddress'] ??
                        property['area'] ??
                        'Location';
                    final String price = property['rentPrice'] != null
                        ? 'Tk ${property['rentPrice']}'
                        : 'Tk 0';

                    final List<dynamic> images = property['images'] ?? [];
                    final String imagePath = images.isNotEmpty
                        ? images.first.toString()
                        : 'assets/images/card_image_1.png';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildAppliedCard(
                        context: context,
                        title: title,
                        location: location,
                        price: price,
                        imagePath: imagePath,
                        propertyData: property,
                      ),
                    );
                  },
                ),
              ],
          ],
        );
      },
    );
  }

  Widget _buildAppliedCard({
    required BuildContext context,
    required String title,
    required String location,
    required String price,
    required String imagePath,
    required Map<String, dynamic> propertyData,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(
              propertyData: propertyData,
              isAppliedView: true,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _buildCardImage(imagePath),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.grey.shade500,
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE86B42),
            ),
          ),
        ],
      ),
    );
  }
}