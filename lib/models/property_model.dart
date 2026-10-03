class PropertyModel {
  final String id;
  final String category;
  final String rooms;
  final String bathrooms;
  final String balcony;
  final String floorLevel;
  final String squareFeet;
  final String rentPrice;
  final String rentPeriod;
  final String division;
  final String district;
  final String area;
  final String coordinates;
  final String phone;
  final String description;
  final String sector;
  final String road;
  final String house;
  final String fullAddress;
  final String landlordId;
  final List<String> images; // <--- This holds your image URLs!
  final String createdAt;

  PropertyModel({
    required this.id,
    required this.category,
    required this.rooms,
    required this.bathrooms,
    required this.balcony,
    required this.floorLevel,
    required this.squareFeet,
    required this.rentPrice,
    required this.rentPeriod,
    required this.division,
    required this.district,
    required this.area,
    required this.coordinates,
    required this.phone,
    required this.description,
    required this.sector,
    required this.road,
    required this.house,
    required this.fullAddress,
    required this.landlordId,
    required this.images,
    required this.createdAt,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> map, String docId) {
    // Safely parse the images list from Firestore so it doesn't get lost
    var rawImages = map['images'];
    List<String> parsedImages = [];
    if (rawImages is List) {
      parsedImages = rawImages.map((e) => e.toString()).toList();
    } else if (rawImages is String && rawImages.isNotEmpty) {
      parsedImages = [rawImages];
    }

    return PropertyModel(
      id: docId,
      category: map['category'] ?? '',
      rooms: map['rooms']?.toString() ?? '0',
      bathrooms: map['bathrooms']?.toString() ?? '0',
      balcony: map['balcony']?.toString() ?? '0',
      floorLevel: map['floorLevel']?.toString() ?? '',
      squareFeet: map['squareFeet']?.toString() ?? '',
      rentPrice: map['rentPrice']?.toString() ?? '0',
      rentPeriod: map['rentPeriod'] ?? 'Monthly',
      division: map['division'] ?? '',
      district: map['district'] ?? '',
      area: map['area'] ?? '',
      coordinates: map['coordinates'] ?? '',
      phone: map['phone'] ?? '',
      description: map['description'] ?? '',
      sector: map['sector'] ?? '',
      road: map['road'] ?? '',
      house: map['house'] ?? '',
      fullAddress: map['fullAddress'] ?? '',
      landlordId: map['landlordId'] ?? '',
      images: parsedImages, // <--- Passes the parsed images safely
      createdAt: map['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'rooms': rooms,
      'bathrooms': bathrooms,
      'balcony': balcony,
      'floorLevel': floorLevel,
      'squareFeet': squareFeet,
      'rentPrice': rentPrice,
      'rentPeriod': rentPeriod,
      'division': division,
      'district': district,
      'area': area,
      'coordinates': coordinates,
      'phone': phone,
      'description': description,
      'sector': sector,
      'road': road,
      'house': house,
      'fullAddress': fullAddress,
      'landlordId': landlordId,
      'images': images, // <--- Actually saves the images to the database
      'createdAt': createdAt,
    };
  }
}