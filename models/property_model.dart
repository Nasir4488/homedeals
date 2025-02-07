import 'dart:convert';

class Property {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final String type;
  final double price;
  final String? currency;
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final double? latitude;
  final double? longitude;
  final int bedrooms;
  final int bathrooms;
  final int? yearBuilt;
  final ListingAgent listingAgent;
  final String label;
  final String status;
  final List<String>? photos;
  final List<String>? videos;
  final List<String>? features;

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
  });
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as String?,
      userId: json['userId'] ?? '',
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
      yearBuilt: json['yearBuilt'] as int?,
      listingAgent: ListingAgent.fromJson(json['listingAgent'] ?? {}),
      label: json['label'] ?? '',
      status: json['status'] ?? '',
      photos: (json['photos'] as List<dynamic>?)?.map((item) => item as String).toList(),
      videos: (json['videos'] as List<dynamic>?)?.map((item) => item as String).toList(),
      features: (json['features'] as List<dynamic>?)?.map((item) => item as String).toList(),
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
      'yearBuilt': yearBuilt,
      'listingAgent': listingAgent.toJson(),
      'label': label,
      'status': status,
      'photos': photos,
      'videos': videos,
      'features': features,
    };
  }
}

class ListingAgent {
  final String name;
  final String email;
  final String? phone;

  ListingAgent({
    required this.name,
    required this.email,
    this.phone,
  });

  factory ListingAgent.fromJson(Map<String, dynamic> json) {
    return ListingAgent(
      name: json['name']??'',
      email: json['email']??'',
      phone: json['phone']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory ListingAgent.fromRawJson(String str) => ListingAgent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
