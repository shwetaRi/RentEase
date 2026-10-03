import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_rent_ease/models/property_model.dart';

class PropertyService {
  final CollectionReference _propertiesRef =
  FirebaseFirestore.instance.collection('properties');

  // Let Firebase configure the bucket automatically from firebase_options.dart
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<String> localFilePaths, String docId) async {
    List<String> downloadUrls = [];

    for (int i = 0; i < localFilePaths.length; i++) {
      File file = File(localFilePaths[i]);

      if (!await file.exists()) {
        continue;
      }

      String fileName = 'property_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      Reference ref = _storage.ref().child('properties/$docId/$fileName');

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } else {
        throw Exception("Failed to upload image $i to Firebase Storage");
      }
    }

    return downloadUrls;
  }

  Future<void> addPropertyWithImages(Map<String, dynamic> rawPropertyData) async {
    DocumentReference docRef = _propertiesRef.doc();
    String newDocId = docRef.id;

    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? 'guest_landlord';

    List<String> localPaths = List<String>.from(rawPropertyData['images'] ?? []);

    // Now forces actual web URLs. No local paths will pollute the database.
    List<String> firestoreImageUrls = await uploadImages(localPaths, newDocId);

    Map<String, dynamic> finalData = Map<String, dynamic>.from(rawPropertyData);
    finalData['images'] = firestoreImageUrls;
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