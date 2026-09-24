import 'package:flutter/material.dart';

class AppliedTab extends StatelessWidget {
  const AppliedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final appliedProperties = [
      {
        'title': 'Studio Flat Rent',
        'location': 'Road #8A, Dhanmondi',
        'price': 'Tk 25,000',
        'image': 'assets/images/card_image_3.png',
      },
      {
        'title': '2-Bedroom Luxury Apt',
        'location': 'Block C, Banani',
        'price': 'Tk 42,000',
        'image': 'assets/images/card_image_4.png',
      },
      {
        'title': 'Bachelor Flat',
        'location': 'Sector 4, Uttara',
        'price': 'Tk 18,000',
        'image': 'assets/images/card_image_1.png',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
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
                    '${appliedProperties.length} Homes Applied',
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

        for (var item in appliedProperties)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildAppliedCard(
              title: item['title']!,
              location: item['location']!,
              price: item['price']!,
              imagePath: item['image']!,
            ),
          ),
      ],
    );
  }

  Widget _buildAppliedCard({
    required String title,
    required String location,
    required String price,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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