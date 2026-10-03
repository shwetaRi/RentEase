import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_rent_ease/screens/select_category.dart';
import 'package:project_rent_ease/screens/profile_view.dart';
import 'package:project_rent_ease/screens/applicant_profile_page.dart';
import 'package:project_rent_ease/widgets/rent_card.dart';

class LandlordDashboardPage extends StatefulWidget {
  const LandlordDashboardPage({super.key});

  @override
  State<LandlordDashboardPage> createState() =>
      _LandlordDashboardPageState();
}

class _LandlordDashboardPageState extends State<LandlordDashboardPage> {
  final Color orange = const Color(0xFFF9834D);

  Widget _emptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 65,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF383838),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yourPropertyTab() {
    final currentLandlordId = FirebaseAuth.instance.currentUser?.uid;

    if (currentLandlordId == null) {
      return const Center(child: Text('Please log in to view properties'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('properties')
          .where('landlordId', isEqualTo: currentLandlordId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _emptyState(
            icon: Icons.home_work_outlined,
            title: 'No Properties Yet',
            message:
            'Tap the + button below to select a category and add your property.',
          );
        }

        final propertyDocs = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
          ),
          itemCount: propertyDocs.length,
          itemBuilder: (context, index) {
            final propData = propertyDocs[index].data() as Map<String, dynamic>;
            final category = propData['category'] ?? 'Flat';
            final location =
                propData['fullAddress'] ?? propData['area'] ?? 'Location';
            final amount =
                int.tryParse(propData['rentPrice']?.toString() ?? '0') ?? 0;

            final List<dynamic> images = propData['images'] ?? [];
            final String imagePath = images.isNotEmpty
                ? images.first.toString()
                : 'assets/images/card_image_1.png';

            return RentCard(
              title: '$category Rent Home',
              location: location,
              amount: amount,
              imagePath: imagePath,
              propertyData: propData,
              showFavoriteIcon: false,
              isLandlordView: true,
            );
          },
        );
      },
    );
  }

  Widget _applicantsTab() {
    final currentLandlordId = FirebaseAuth.instance.currentUser?.uid;

    if (currentLandlordId == null) {
      return const Center(child: Text('Please log in to view applicants'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('landlordId', isEqualTo: currentLandlordId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _emptyState(
            icon: Icons.people_outline,
            title: 'No Applicants Yet',
            message: 'People who apply for your properties will appear here.',
          );
        }

        final bookingDocs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: bookingDocs.length,
          itemBuilder: (context, index) {
            final bookingDoc = bookingDocs[index];
            final booking = bookingDoc.data() as Map<String, dynamic>;
            final docId = bookingDoc.id;

            final applicantId = booking['applicantId'] ?? 'Unknown Tenant';
            final propertyData = booking['propertyData'] as Map<String, dynamic>? ?? {};

            final title = propertyData['category'] != null
                ? '${propertyData['category']} Rent Home'
                : 'Rent Home';
            final rentPrice = propertyData['rentPrice'] ?? '0';
            final status = booking['status'] ?? 'Pending';

            return GestureDetector(
              onTap: () {
                // If it is pending, let the landlord view the profile and decide.
                if (status == 'Pending') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplicantProfilePage(
                        applicantId: applicantId,
                        bookingId: docId,
                      ),
                    ),
                  );
                } else {
                  // Inform them it's already processed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('This application is already $status')),
                  );
                }
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person_outline,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Applicant ID: $applicantId',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rent: TK $rentPrice',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFF9834D),
                            ),
                          ),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: status == 'Accepted'
                                  ? Colors.green
                                  : status == 'Rejected'
                                  ? Colors.red
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Landlord Dashboard',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Color(0xFF383838),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFE6DBD7),
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ),
            ),
          ],
          bottom: TabBar(
            labelColor: orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: orange,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Your Property'),
              Tab(text: 'Applicants'),
            ],
          ),
        ),

        // Tab Content
        body: TabBarView(
          children: [
            _yourPropertyTab(),
            _applicantsTab(),
          ],
        ),

        // Floating '+' Button to add property
        floatingActionButton: FloatingActionButton(
          backgroundColor: orange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectCategory(),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}