import 'package:flutter/material.dart';

class ResponseTab extends StatelessWidget {
  const ResponseTab({super.key});

  @override
  Widget build(BuildContext context) {
    final responses = [
      {
        'title': 'Family Flat Rent',
        'location': 'Road #12, Block G, Dhanmondi',
        'status': 'Accepted',
        'statusColor': Colors.green,
        'image': 'assets/images/card_image_3.png',
      },
      {
        'title': 'Studio Flat Rent',
        'location': 'Road #8A, Dhanmondi',
        'status': 'Rejected',
        'statusColor': Colors.red,
        'image': 'assets/images/card_image_1.png',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        for (var item in responses)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildResponseCard(
              title: item['title'] as String,
              location: item['location'] as String,
              status: item['status'] as String,
              statusColor: item['statusColor'] as Color,
              imagePath: item['image'] as String,
            ),
          ),
      ],
    );
  }

  Widget _buildResponseCard({
    required String title,
    required String location,
    required String status,
    required Color statusColor,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
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
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}