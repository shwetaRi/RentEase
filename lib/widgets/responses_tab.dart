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
        'image': 'assets/images/card_image_3.png.png',
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: responses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final item = responses[index];
            return _buildResponseCard(
              title: item['title'] as String,
              location: item['location'] as String,
              status: item['status'] as String,
              statusColor: item['statusColor'] as Color,
              imagePath: item['image'] as String,
            );
          },
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
    return InkWell(
      onTap: () {
        // Tap handler for response card
      },
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey.shade200,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.home, size: 40, color: Colors.grey),
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
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}