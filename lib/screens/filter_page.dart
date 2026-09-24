import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final String propertyType;
  final double minPrice;
  final double maxPrice;
  final int bedrooms;

  const FilterPage({
    super.key,
    required this.propertyType,
    required this.minPrice,
    required this.maxPrice,
    required this.bedrooms,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final Color orange = const Color(0xFFF9834D);

  late String selectedPropertyType;
  int selectedBedrooms = 0;
  int selectedBathrooms = 0;

  String? selectedFeature;
  final TextEditingController minPriceController =
  TextEditingController();

  final TextEditingController maxPriceController =
  TextEditingController();

  final TextEditingController keywordController =
  TextEditingController();

  final List<String> propertyTypes = [
    'All',
    'Family',
    'Bachelor',
    'Office',
    'Sublet',
    'Hostel',
  ];

  final List<int> bedrooms = [1, 2, 3, 4, 5, 6, 7];

  final List<String> bathrooms = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6+',
  ];

  final List<String> features = [
    'LIFT',
    'GARAGE',
    'CCTV',
    'GAS',
  ];

  @override
  void initState() {
    super.initState();

    selectedPropertyType = widget.propertyType;

    if (widget.bedrooms > 0) {
      selectedBedrooms = widget.bedrooms;
    }

    if (widget.minPrice > 0) {
      minPriceController.text = widget.minPrice.toInt().toString();
    }

    if (widget.maxPrice < 100000) {
      maxPriceController.text = widget.maxPrice.toInt().toString();
    }
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    keywordController.dispose();
    super.dispose();
  }

  bool get isComplete {
    return selectedPropertyType != 'All' &&
        minPriceController.text.isNotEmpty &&
        maxPriceController.text.isNotEmpty &&
        selectedBedrooms != 0 &&
        selectedBathrooms != 0 &&
        selectedFeature != null &&
        keywordController.text.isNotEmpty;
  }

  void resetFilter() {
    setState(() {
      selectedPropertyType = 'All';
      selectedBedrooms = 0;
      selectedBathrooms = 0;
      selectedFeature = null;

      minPriceController.clear();
      maxPriceController.clear();
      keywordController.clear();
    });
  }

  void showProperty() {
    if (!isComplete) return;

    final double minPrice =
        double.tryParse(minPriceController.text) ?? 5000;

    final double maxPrice =
        double.tryParse(maxPriceController.text) ?? 100000;

    Navigator.pop(context, {
      'propertyType': selectedPropertyType,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'bedrooms': selectedBedrooms,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9FD),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9FD),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Filter',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        actions: [
          TextButton(
            onPressed: resetFilter,
            child: const Text(
              'RESET',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



            const Text(
              '🏢  Property Types',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF444044),
              ),
            ),

            const SizedBox(height: 18),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: propertyTypes.map((type) {
                  final bool selected =
                      selectedPropertyType == type;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(type),
                      selected: selected,

                      selectedColor:
                      orange.withOpacity(0.20),

                      backgroundColor:
                      const Color(0xFFEAF2FC),

                      side: BorderSide(
                        color: selected
                            ? orange
                            : const Color(0xFF9A9A9A),
                      ),

                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: selected
                            ? orange
                            : const Color(0xFF444044),
                      ),

                      onSelected: (_) {
                        setState(() {
                          selectedPropertyType = type;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 40),



            const Text(
              '💵  Price range',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF444044),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,

                    onChanged: (_) {
                      setState(() {});
                    },

                    decoration: InputDecoration(
                      labelText: 'Minimum',
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: orange,
                          width: 1.5,
                        ),
                      ),

                      labelStyle: const TextStyle(
                        fontSize: 17,
                      ),

                      floatingLabelStyle: TextStyle(
                        color: orange,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                const Text(
                  'to',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,

                    onChanged: (_) {
                      setState(() {});
                    },

                    decoration: InputDecoration(
                      labelText: 'Maximum',
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: orange,
                          width: 1.5,
                        ),
                      ),

                      labelStyle: const TextStyle(
                        fontSize: 17,
                      ),

                      floatingLabelStyle: TextStyle(
                        color: orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),



            const Text(
              '🛏  Bedrooms',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF444044),
              ),
            ),

            const SizedBox(height: 18),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: bedrooms.map((number) {
                  return _numberButton(
                    number.toString(),
                    selectedBedrooms == number,
                        () {
                      setState(() {
                        selectedBedrooms = number;
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 40),



            const Text(
              '🛁  Bathrooms',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF444044),
              ),
            ),

            const SizedBox(height: 18),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: bathrooms.map((number) {
                  return _numberButton(
                    number,
                    selectedBathrooms.toString() == number,
                        () {
                      setState(() {
                        selectedBathrooms =
                        number == '6+'
                            ? 6
                            : int.parse(number);
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 40),



            const Text(
              '🪄  Features',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF444044),
              ),
            ),

            const SizedBox(height: 18),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: features.map((feature) {
                  final bool selected =
                      selectedFeature == feature;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(feature),
                      selected: selected,

                      selectedColor:
                      orange.withOpacity(0.20),

                      backgroundColor:
                      const Color(0xFFEAF2FC),

                      side: BorderSide(
                        color: selected
                            ? orange
                            : const Color(0xFF9A9A9A),
                      ),

                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: selected
                            ? orange
                            : const Color(0xFF444044),
                      ),

                      onSelected: (_) {
                        setState(() {
                          selectedFeature = feature;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 40),



            const Text(
              '🔎  Keyword',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF444044),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: keywordController,

              onChanged: (_) {
                setState(() {});
              },

              decoration: InputDecoration(
                labelText: 'Enter relevant keyword',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: orange,
                    width: 1.5,
                  ),
                ),

                floatingLabelStyle: TextStyle(
                  color: orange,
                ),
              ),
            ),

            const SizedBox(height: 55),

            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed:
                isComplete ? showProperty : null,

                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,

                  disabledBackgroundColor:
                  const Color(0xFFD8D2D0),

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(30),
                  ),
                ),

                child: const Text(
                  'Show Property',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _numberButton(
      String text,
      bool selected,
      VoidCallback onTap,
      ) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(12),

        child: Container(
          width: 64,
          height: 56,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: selected
                ? orange.withOpacity(0.20)
                : const Color(0xFFEAF2FC),

            border: Border.all(
              color: selected
                  ? orange
                  : const Color(0xFF9A9A9A),
            ),

            borderRadius:
            BorderRadius.circular(12),
          ),

          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: selected
                  ? orange
                  : const Color(0xFF444044),
            ),
          ),
        ),
      ),
    );
  }
}