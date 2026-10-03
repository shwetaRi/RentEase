import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResponseTab extends StatelessWidget {
  const ResponseTab({super.key});

  void _showRejectedPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.back_hand_outlined, color: Colors.blue, size: 28),
            SizedBox(width: 10),
            Text('Rejected'),
          ],
        ),
        content: const Text(
          'Sorry, your application for this property was rejected by the landlord.',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  void _showPendingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.cancel, color: Colors.red, size: 28),
            SizedBox(width: 10),
            Text('Pending'),
          ],
        ),
        content: const Text(
          'Your application for this property is being reviewd by the landlord.',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showAcceptedDetails(BuildContext context, Map<String, dynamic> propertyData) {
    final phone = propertyData['phone'] ?? 'Not provided';
    final address = propertyData['fullAddress'] ?? 'Not provided';
    final landlordId = propertyData['landlordId'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 10),
                Text(
                  'Application Accepted!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Contact the landlord to proceed:', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),

            if (landlordId != null)
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(landlordId).get(),
                builder: (context, snapshot) {
                  String landlordName = 'Loading...';
                  if (snapshot.hasData && snapshot.data!.exists) {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    landlordName = data['fullName'] ?? data['username'] ?? 'Landlord';
                  }
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFF0EC),
                      child: Icon(Icons.person, color: Color(0xFFE86B42)),
                    ),
                    title: const Text('Landlord Name', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    subtitle: Text(landlordName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                    contentPadding: EdgeInsets.zero,
                  );
                },
              ),

            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFF0EC),
                child: Icon(Icons.phone, color: Color(0xFFE86B42)),
              ),
              title: const Text('Phone Number', style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(phone, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
              contentPadding: EdgeInsets.zero,
            ),

            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFF0EC),
                child: Icon(Icons.location_on, color: Color(0xFFE86B42)),
              ),
              title: const Text('Property Address', style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(address, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE86B42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Close Details', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      return const Center(
        child: Text('Please log in to view responses'),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('applicantId', isEqualTo: currentUserId) // Removed 'whereIn' filter so Pending shows up too!
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFE86B42)));
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No responses received yet',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final bookingDocs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookingDocs.length,
          itemBuilder: (context, index) {
            final booking = bookingDocs[index].data() as Map<String, dynamic>;
            final status = booking['status'] ?? 'Pending';

            final propertyData = booking['propertyData'] as Map<String, dynamic>? ?? {};
            final category = propertyData['category'] ?? 'Flat';
            final title = '$category Rent Home';
            final rentPrice = propertyData['rentPrice'] ?? '0';
            final address = propertyData['fullAddress'] ?? propertyData['area'] ?? '';

            Color statusColor = Colors.orange; // Default Pending
            if (status == 'Accepted') statusColor = Colors.green;
            if (status == 'Rejected') statusColor = Colors.red;

            return GestureDetector(
              onTap: () {
                if (status == 'Pending') {
                  _showPendingPopup(context);
                } else if (status == 'Rejected') {
                  _showRejectedPopup(context);
                } else if (status == 'Accepted') {
                  _showAcceptedDetails(context, propertyData);
                }
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
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
                            const SizedBox(height: 6),
                            if (address.toString().isNotEmpty)
                              Text(
                                address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            const SizedBox(height: 8),
                            Text(
                              'Rent: TK $rentPrice',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFE86B42),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor, width: 1.5),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
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
}