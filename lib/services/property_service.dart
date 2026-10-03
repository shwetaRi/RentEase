import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_rent_ease/models/property_model.dart';

class PropertyService {
  final CollectionReference _propertiesRef =
  FirebaseFirestore.instance.collection('properties');

  // Paste your free API key from api.imgbb.com here:
  final String _imgbbApiKey = '9286ebdc6828c0dbcec5f911fbcb226d';

  Future<List<String>> uploadImages(List<String> localFilePaths) async {
    List<String> downloadUrls = [];

    for (int i = 0; i < localFilePaths.length; i++) {
      File file = File(localFilePaths[i]);

      if (!await file.exists()) {
        continue;
      }

      try {
        // Use MultipartRequest to send the actual file directly
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://api.imgbb.com/1/upload'),
        );

        request.fields['key'] = _imgbbApiKey;
        request.files.add(await http.MultipartFile.fromPath('image', file.path));

        // Send the request and wait for the response
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          // Extract the direct image URL from ImgBB's response
          String imageUrl = jsonResponse['data']['url'];
          downloadUrls.add(imageUrl);
        } else {
          throw Exception("ImgBB Error: ${response.body}");
        }
      } catch (e) {
        throw Exception("Error uploading image $i: $e");
      }
    }

    return downloadUrls;
  }

  Future<void> addPropertyWithImages(Map<String, dynamic> rawPropertyData) async {
    DocumentReference docRef = _propertiesRef.doc();
    String newDocId = docRef.id;

    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? 'guest_landlord';

    List<String> localPaths = List<String>.from(rawPropertyData['images'] ?? []);

    // Upload to ImgBB and get the public URLs back
    List<String> hostedImageUrls = await uploadImages(localPaths);

    Map<String, dynamic> finalData = Map<String, dynamic>.from(rawPropertyData);
    finalData['images'] = hostedImageUrls;
    finalData['landlordId'] = currentUserId;

    PropertyModel property = PropertyModel.fromMap(finalData, newDocId);
    await docRef.set(property.toMap());
  }

  // Stream all properties for Home Feed
  Stream<List<PropertyModel>> getPropertiesStream() {
    return _propertiesRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return PropertyModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  // Helper method for Landlord Dashboard
  Stream<List<PropertyModel>> getLandlordPropertiesStream(String landlordId) {
    return _propertiesRef
        .where('landlordId', isEqualTo: landlordId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return PropertyModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }
}