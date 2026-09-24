import 'package:flutter/material.dart';
import 'package:project_rent_ease/widgets/property_counter.dart';
import 'package:project_rent_ease/screens/home_page.dart';

class PropertyInfoPage extends StatefulWidget {
  final String selectedCategory; // Stores 'Family', 'Office', etc.

  const PropertyInfoPage({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<PropertyInfoPage> createState() => _PropertyInfoPageState();
}

class _PropertyInfoPageState extends State<PropertyInfoPage> {
  int roomTotal =0;
  int bathrooms =0;
  int balcony =0;
  final TextEditingController _floorLevelController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  @override
  void dispose() {
    _sizeController.dispose();
    _floorLevelController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Information',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Color(0xFF000000),
        ), // TextStyle
      ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               width: 45,
                               height: 45,
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color(0xFF006400)
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(3.5),
                                 child: Text(
                                   '1',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFFFFFFFF),
                                     fontWeight: FontWeight.w600,
                                     fontSize: 25,
                                   ),
                                 ),
                               ),
                             ),
                             Container(
                               width: 45,
                               height: 45,
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color(0xFF90EE90)
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(3.5),
                                 child: Text(
                                   '2',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFFFFFFFF),
                                     fontWeight: FontWeight.w600,
                                     fontSize: 25,
                                   ),
                                 ),
                               ),
                             ),
                             Container(
                               width: 45,
                               height: 45,
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color(0xFF808080)
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(3.5),
                                 child: Text(
                                   '3',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFFFFFFFF),
                                     fontWeight: FontWeight.w600,
                                     fontSize: 25,
                                   ),
                                 ),
                               ),
                             ),
                             Container(
                               width: 45,
                               height: 45,
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color(0xFF808080)
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(3.5),
                                 child: Text(
                                   '4',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFFFFFFFF),
                                     fontWeight: FontWeight.w600,
                                     fontSize: 25,
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(height: 48),
                       PropertyCounter(
                           label: 'No. of Rooms',
                           value: roomTotal,
                           onChanged: (val) {
                             setState(() => roomTotal = val);
                           },
                           ),
                       SizedBox(height: 12),
                       PropertyCounter(
                         label: 'No. of Bathrooms',
                         value: bathrooms,
                         onChanged: (val) {
                           setState(() => bathrooms = val);
                         },
                       ),
                       SizedBox(height: 12),
                       PropertyCounter(
                         label: 'No. of Balcony',
                         value: balcony,
                         onChanged: (val) {
                           setState(() => balcony = val);
                         },
                       ),
                       SizedBox(height: 20),
                       Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                           border: Border.all(
                             color: Color(0xFFE0E0E0)
                           )
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                           children: [
                             Container(
                               padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                               decoration: BoxDecoration(
                                 color: Color(0xFF70D6F6),
                                 borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(11),
                                   topRight: Radius.circular(11)
                                 )
                               ),
                               child: Text(
                                 'Floor Level',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.w600,
                                   fontSize: 18,
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 12),
                               child: TextField(
                                 controller: _floorLevelController, // Uses the controller properly
                                 decoration: const InputDecoration(
                                   hintText: 'Enter Floor Level (e.g. 1st Floor)',
                                   border: OutlineInputBorder(),
                                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                       SizedBox(height: 20),
                       Text(
                         'Area in Sq.Ft. (optional)',
                         style: TextStyle(
                           fontWeight: FontWeight.w600,
                           fontSize: 18,
                           color: Color(0xFF000000),
                         ),
                       ),
                       Row(
                         children: [
                           Expanded(
                             child: TextField(
                               controller: _sizeController,
                               keyboardType: TextInputType.number,
                               decoration: const InputDecoration(
                                 hintText: 'Room Size',
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.only(
                                     topLeft: Radius.circular(8),
                                     bottomLeft: Radius.circular(8),
                                   ),
                                 ),
                                 contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                               ),
                             ),
                           ),
                           Container(
                             height: 48,
                             padding: const EdgeInsets.symmetric(horizontal: 16),
                             alignment: Alignment.center,
                             decoration: const BoxDecoration(
                               color: Color(0xFFBFEFFF),
                               borderRadius: BorderRadius.only(
                                 topRight: Radius.circular(8),
                                 bottomRight: Radius.circular(8),
                               ),
                             ),
                             child: const Text(
                               'Sq.Ft.',
                               style: TextStyle(
                                 color: Color(0xFF007A9E),
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                         ],
                       ),
                       SizedBox(height: 30),
                     ],
                   ),
                 ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> propertyData = {
                        'category': widget.selectedCategory,
                        'rooms': roomTotal,
                        'bathrooms': bathrooms,
                        'balcony': balcony,
                        'floorLevel': _floorLevelController.text,
                        'squareFeet': _sizeController.text,
                      };
                      debugPrint("Property Data Collected: $propertyData");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ), // MaterialPageRoute
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A3E0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}