import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_rent_ease/widgets/property_image.dart';
import 'package:project_rent_ease/widgets/property_details.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? propertyData;
  const PropertyDetailsPage({
    super.key,
  this.propertyData
  });

  @override
  State<PropertyDetailsPage> createState() => _PropertyState();
}

class _PropertyState extends State<PropertyDetailsPage> {
  bool isFavourite=false;
  @override
  Widget build(BuildContext context) {
    final String category = widget.propertyData?['category'] ?? 'Flat';
    final String rooms = widget.propertyData?['rooms']?.toString() ?? '3';
    final String bathrooms = widget.propertyData?['bathrooms']?.toString() ?? '2';
    final String sqft = (widget.propertyData?['squareFeet'] != null &&
        widget.propertyData!['squareFeet'].toString().isNotEmpty)
        ? widget.propertyData!['squareFeet'].toString()
        : '1550';
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Image(image: AssetImage('assets/images/card_image_4.png'),
                    width: double.infinity,
                    height: 436,
                    fit: BoxFit.cover,
                    ),
                    Positioned(
                        left: 10,
                    top:10,
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                          child: Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              color: Color(0x33000000),
                              shape: BoxShape.circle
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                                onPressed:(){
                                Navigator.pop(context);
                          }
                                ),

                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               '$category Rent Home',
                               style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000)
                               ),
                             ),
                             SizedBox(height: 8),
                           Row(
                    children:[
                      Icon(
                    Icons.location_on_outlined,
                        size:23,
                        color: Color(0xFF000000),
                ),
                      SizedBox(width: 2),
                      Text(
                        "Road # 12, Block G,Dhanmondi",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ]
                )
                           ],
                         ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isFavourite =!isFavourite;
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
                            isFavourite ? Icons.favorite:Icons.favorite_border,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Photos',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000)
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                PropertyImage(image: AssetImage('assets/images/Sample Flat1/Bedroom.png'),
                                label: 'BedRoom'
                            ),
                            PropertyImage(image: AssetImage('assets/images/Sample Flat1/Livingroom.png'),
                                label: 'Livingroom'
                            ),
                            PropertyImage(image: AssetImage('assets/images/Sample Flat1/Kitchen.png'),
                                label: 'Kitchen'
                            ),
                                    ],
                        ),
                      ),
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Property Details',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000)
                                  ),
                                ),
                                TextButton(onPressed: (){},
                                    child: Text(
                                      'See More',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    )
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PropertyDetails.bedrooms(value: rooms),
                                PropertyDetails.bathrooms(value: bathrooms),
                                PropertyDetails.area(value: sqft)
                              ],
                            ),
                          ],
                        ),

                    ],
                  ),
                )
              ],
            )

        )
      ),
      bottomSheet: Container(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,bottom: 20),
          child: Container(
            height: 71,
            decoration: BoxDecoration(
              color: Color(0xFF0F0804),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'TK 15,000',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF073CFE),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                    onPressed: (){},
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF)
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

