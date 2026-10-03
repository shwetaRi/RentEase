import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_rent_ease/models/property_model.dart';
import 'package:project_rent_ease/services/property_service.dart';
import 'package:project_rent_ease/screens/home_page.dart';

class PropertyImagesPage extends StatefulWidget {
  final Map<String, dynamic> propertyData;

  const PropertyImagesPage({
    super.key,
    required this.propertyData,
  });

  @override
  State<PropertyImagesPage> createState() => _PropertyImagesPageState();
}

class _PropertyImagesPageState extends State<PropertyImagesPage> {
  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  bool showError = false;
  bool isLoading = false;
  String errorMessage = 'Incomplete Information';

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          if (images.length > 6) {
            _selectedImages.clear();
            _selectedImages.addAll(images.take(6));
            _triggerError('Maximum 6 images allowed');
          } else {
            _selectedImages.clear();
            _selectedImages.addAll(images);
          }
        });
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
  }

  void _removeImages() {
    setState(() {
      _selectedImages.clear();
    });
  }

  void _triggerError(String message) {
    setState(() {
      errorMessage = message;
      showError = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showError = false;
        });
      }
    });
  }

  void _validateAndPost() async {
    if (_selectedImages.length < 4) {
      _triggerError('Select at least 4 images');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> completePropertyData = {
        ...widget.propertyData,
        'images': _selectedImages.map((e) => e.path).toList(),
        'createdAt': DateTime.now().toIso8601String(),
      };
      await PropertyService().addPropertyWithImages(completePropertyData);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Property Posted Successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        _triggerError('Failed to post property: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Property Images',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Wizard Step Indicators
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF006400),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
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
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF006400),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
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
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF006400),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
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
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF90EE90),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.5),
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
                          const SizedBox(height: 30),

                          const Text(
                            '• First images will be Thumbnails/Display image.',
                            style: TextStyle(
                              color: Color(0xFF00C897),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '• Select Minimum 4 and Maximum 6 Images of your property.',
                            style: TextStyle(
                              color: Color(0xFF00A3E0),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Photo Picker Box
                          GestureDetector(
                            onTap: isLoading ? null : _pickImages,
                            child: Container(
                              height: 220,
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F6FC),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF00A3E0),
                                  width: 1.8,
                                ),
                              ),
                              child: _selectedImages.isEmpty
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 60,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00A3E0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'SELECT IMAGES',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                                  : GridView.builder(
                                itemCount: _selectedImages.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(_selectedImages[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          if (_selectedImages.isNotEmpty && !isLoading)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _removeImages,
                                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                                    label: const Text(
                                      'Remove Images',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Colors.red),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _pickImages,
                                    icon: const Icon(Icons.refresh, color: Colors.white),
                                    label: const Text(
                                      'Change Images',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00A3E0),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: isLoading ? null : () => Navigator.pop(context),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: isLoading ? null : _validateAndPost,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A3E0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'POST',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showError)
              Positioned(
                bottom: 80,
                left: 20,
                right: 20,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red.shade600,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.white, size: 24),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}