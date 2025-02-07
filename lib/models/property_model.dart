import 'package:hive/hive.dart';

part 'property_model.g.dart';

@HiveType(typeId: 0)
class Property {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final double price;
  @HiveField(6)
  final String? currency;
  @HiveField(7)
  final String address;
  @HiveField(8)
  final String city;
  @HiveField(9)
  final String state;
  @HiveField(10)
  final String country;
  @HiveField(11)
  final String zipCode;
  @HiveField(12)
  final double? latitude;
  @HiveField(13)
  final double? longitude;
  @HiveField(14)
  final int bedrooms;
  @HiveField(15)
  final int bathrooms;
  @HiveField(16)
  final DateTime? yearBuilt;
  @HiveField(17)
  final ListingAgent listingAgent;
  @HiveField(18)
  final String label;
  @HiveField(19)
  final String status;
  @HiveField(20)
  final List<String>? photos;
  @HiveField(21)
  final List<String>? videos;
  @HiveField(22)
  final List<String>? features;
  @HiveField(23)
  final int? area;
  @HiveField(24)
  final bool? isfeatured;


  Property({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.type,
    required this.price,
    this.currency,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    this.latitude,
    this.longitude,
    required this.bedrooms,
    required this.bathrooms,
    this.yearBuilt,
    required this.listingAgent,
    required this.label,
    required this.status,
    this.photos,
    this.videos,
    this.features,
    this.area,
    this.isfeatured
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    DateTime? listingDateTime = json['listingDate'] != null
        ? DateTime.parse(json['listingDate'])
        : null;

    return Property(
      id: json['_id'] as String?,
      userId: json['userid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'USD',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      yearBuilt: listingDateTime,
      listingAgent: ListingAgent.fromJson(json['listingAgent'] ?? {}),
      label: json['label'] ?? '',
      status: json['status'] ?? '',
      photos: (json['photos'] as List<dynamic>?)?.map((item) => item as String).toList(),
      videos: (json['videos'] as List<dynamic>?)?.map((item) => item as String).toList(),
      features: (json['features'] as List<dynamic>?)?.map((item) => item as String).toList(),
      area: json['area'] ?? 0,
      isfeatured: json['isfeatured'] ?? false,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userId,
      'title': title,
      'description': description,
      'type': type,
      'price': price,
      'currency': currency,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'latitude': latitude,
      'longitude': longitude,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      // 'listingDate': yearBuilt?.toIso8601String(),
      'listingAgent': listingAgent.toJson(),
      'label': label,
      'status': status,
      'photos': photos,
      'videos': videos,
      'features': features,
      'area':area,
      'isfeatured':isfeatured
    };
  }
}

@HiveType(typeId: 1)
class ListingAgent {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String? phone;

  ListingAgent({
    required this.name,
    required this.email,
    this.phone,
  });

  factory ListingAgent.fromJson(Map<String, dynamic> json) {
    return ListingAgent(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
