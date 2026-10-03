import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_rent_ease/screens/select_category.dart';
import 'package:project_rent_ease/screens/favorite_page.dart';

class LandlordDashboardPage extends StatefulWidget {
  const LandlordDashboardPage({super.key});

  @override
  State<LandlordDashboardPage> createState() =>
      _LandlordDashboardPageState();
}

class _LandlordDashboardPageState extends State<LandlordDashboardPage> {
  final Color orange = const Color(0xFFF9834D);
  final Color navColor = const Color(0xFFF0E3E7);

  // Status (Accept / Reject) Update Function
  Future<void> _updateBookingStatus(
      BuildContext context, String docId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(docId)
          .update({'status': newStatus});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated to $newStatus')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update status: $e')),
        );
      }
    }
  }

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

  // Your Property Tab (Fetches properties uploaded by landlord)
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

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: propertyDocs.length,
          itemBuilder: (context, index) {
            final property =
            propertyDocs[index].data() as Map<String, dynamic>;
            final category = property['category'] ?? 'Flat';
            final rentPrice = property['rentPrice'] ?? '0';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.home, color: Color(0xFFF9834D)),
                title: Text(
                  '$category Rent Home',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Rent: TK $rentPrice'),
              ),
            );
          },
        );
      },
    );
  }

  // Applicants Tab (Fetches booking requests for this landlord)
  Widget _applicantsTab() {
    final currentLandlordId = FirebaseAuth.instance.currentUser?.uid;

    if (currentLandlordId == null) {
      return const Center(child: Text('Please log in to view applicants'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
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
            message:
            'People who apply for your properties will appear here.',
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

            final tenantId = booking['tenantId'] ?? 'Unknown Tenant';
            final title = booking['title'] ?? 'Rent Home';
            final rentPrice = booking['rentPrice'] ?? '15000';
            final status = booking['status'] ?? 'Pending';

            return Card(
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
                              'Tenant User ID: $tenantId',
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
                    Text(
                      'Rent: TK $rentPrice',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF9834D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (status == 'Pending')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () =>
                                _updateBookingStatus(context, docId, 'Accepted'),
                            icon: const Icon(Icons.check,
                                size: 18, color: Colors.white),
                            label: const Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () =>
                                _updateBookingStatus(context, docId, 'Rejected'),
                            icon: const Icon(Icons.close,
                                size: 18, color: Colors.white),
                            label: const Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    else
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Status: $status',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: status == 'Accepted'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: 76,
      color: navColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Image.asset(
              'assets/icons/home.png',
              height: 24,
              width: 24,
            ),
          ),
          Icon(
            Icons.dashboard,
            size: 26,
            color: orange,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectCategory(),
                ),
              );
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: orange.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
            child: Image.asset(
              'assets/icons/love.png',
              height: 24,
              width: 24,
            ),
          ),
          // Profile
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Landlord profile coming soon.',
                  ),
                ),
              );
            },
            child: Image.asset(
              'assets/icons/profile.png',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
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

        // Bottom Navigation
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }
}