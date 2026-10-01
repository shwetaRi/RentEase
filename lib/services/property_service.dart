import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_rent_ease/models/property_model.dart';

class PropertyService {
  final CollectionReference _propertiesRef =
  FirebaseFirestore.instance.collection('properties');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<String> localFilePaths, String docId) async {
    List<String> downloadUrls = [];

    for (int i = 0; i < localFilePaths.length; i++) {
      File file = File(localFilePaths[i]);
      String fileName = 'property_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';


      Reference ref = _storage.ref().child('properties/$docId/$fileName');
      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }


  Future<void> addPropertyWithImages(Map<String, dynamic> rawPropertyData) async {

    DocumentReference docRef = _propertiesRef.doc();
    String newDocId = docRef.id;


    List<String> localPaths = List<String>.from(rawPropertyData['images'] ?? []);


    List<String> firestoreImageUrls = await uploadImages(localPaths, newDocId);


    Map<String, dynamic> finalData = Map<String, dynamic>.from(rawPropertyData);
    finalData['images'] = firestoreImageUrls;


    PropertyModel property = PropertyModel.fromMap(finalData, newDocId);
    await docRef.set(property.toMap());
  }

  // Stream live property listings for HomePage feed
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
}