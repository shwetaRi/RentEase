import 'package:flutter/material.dart';
import 'package:project_rent_ease/screens/favorite_page.dart';
import 'package:project_rent_ease/widgets/rent_card.dart';
import 'package:project_rent_ease/widgets/bottom_nav_bar.dart';
import 'package:project_rent_ease/screens/filter_page.dart';
import 'package:project_rent_ease/screens/location_page.dart';
import 'package:project_rent_ease/models/property_model.dart';
import 'package:project_rent_ease/services/property_service.dart';

class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex=0;
  String profileImagePath = 'assets/images/profile.png';
  String selectedLocation ='Location';
  String selectedSort ='Sort';

  String selectedPropertyType ='All';
  double minPrice =5000;
  double maxPrice =100000;
  int selectedBedrooms =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(image: AssetImage('assets/images/logo.png'), width: 150),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(profileImagePath),
                              fit: BoxFit.cover,
                            ),
                            color: Color(0xFFE6DBD7),
                            borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text('Discover verified homes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF383838),
                    ),
                  ),
                ),
                 SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF171616),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            setState(() {
                              selectedSort =value;
                            });
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.sort,
                                  size: 18,
                                  color: Colors.black87,
                                ),

                                const SizedBox(width: 3),

                                Flexible(
                                  child: Text(
                                    selectedSort == 'Price: Low → High'
                                        ? 'Low → High'
                                        : selectedSort == 'Price: High → Low'
                                        ? 'High → Low'
                                        : selectedSort,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 2),

                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: ' Low → High ',
                              child: Text('Price (Low → High)'),
                            ),
                            PopupMenuItem(
                              value: ' High → Low ',
                              child: Text('Price (High → Low)'),
                            ),
                            PopupMenuItem(
                              value: 'Newest',
                              child: Text('Newest'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final location = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LocationPage(),
                            ),
                          );

                          if (location != null) {
                            setState(() {
                              selectedLocation = location;
                            });
                          }
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF171616),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 21,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  selectedLocation,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // FILTER
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterPage(
                                propertyType: selectedPropertyType,
                                minPrice: minPrice,
                                maxPrice: maxPrice,
                                bedrooms: selectedBedrooms,
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              selectedPropertyType = result['propertyType'];
                              minPrice = result['minPrice'];
                              maxPrice = result['maxPrice'];
                              selectedBedrooms = result['bedrooms'];
                            });
                          }
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF171616),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.tune,
                                size: 21,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Home Rents',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF383838),
                        ),
                      ),
                      Text('See all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFF9834D),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                StreamBuilder<List<PropertyModel>>(
                  stream: PropertyService().getPropertiesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: CircularProgressIndicator(color: Color(0xFF00A3E0)),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'Error loading listings: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }

                    final properties = snapshot.data ?? [];

                    if (properties.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            'No properties posted yet.',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        final prop = properties[index];

                        return RentCard(
                          title: '${prop.category} Rent Home',
                          location: prop.fullAddress.isNotEmpty ? prop.fullAddress : prop.area,
                          amount: int.tryParse(prop.rentPrice) ?? 0,
                          imagePath: prop.images.isNotEmpty
                              ? prop.images.first
                              : 'assets/images/card_image_1.png',
                          propertyData: prop.toMap(),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) async {
          if (index == 2) {
            setState(() {
              currentIndex = 2;
            });

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoritePage(),
              ),
            );

            if (mounted) {
              setState(() {
                currentIndex = 0;
              });
            }
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),

    );
  }
}