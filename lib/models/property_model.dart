class PropertyModel {
  final String? id;
  final String category;
  final int rooms;
  final int bathrooms;
  final int balcony;
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
  final List<String> images;
  final DateTime createdAt;

  PropertyModel({
    this.id,
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
    required this.images,
    required this.createdAt,
  });

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
      'images': images,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map, String docId) {
    return PropertyModel(
      id: docId,
      category: map['category'] ?? 'Flat',
      rooms: map['rooms'] ?? 0,
      bathrooms: map['bathrooms'] ?? 0,
      balcony: map['balcony'] ?? 0,
      floorLevel: map['floorLevel'] ?? '',
      squareFeet: map['squareFeet'] ?? '',
      rentPrice: map['rentPrice'] ?? '0',
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
      images: List<String>.from(map['images'] ?? []),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}