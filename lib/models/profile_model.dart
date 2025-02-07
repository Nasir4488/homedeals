class Profile {
  final String userId;
  final String? phoneNumber;
  final String? description;
  final String? profilePicture;
  final String? taxId;
  final String? office;
  final String? mobile;
  final String? address;
  final String? faxId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    required this.userId,
    this.phoneNumber,
    this.description,
    this.profilePicture,
    this.address,
    this.mobile,
    this.office,
    this.taxId,
    this.faxId,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create a Profile from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['userId'] ?? '',
      // Provide a default empty string if null
      phoneNumber: json['phoneNumber'],
      // Can be null
      description: json['description'],
      // Can be null
      profilePicture: json['profilePicture'],

      taxId: json['taxId'],
      faxId: json['faxId'],
      address: json['address'],
      mobile: json['mobile'],
      office: json['office'],

      // Can be null
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // Method to convert Profile object to JSON
  // `includeTimestamps` controls whether to send timestamps in requests
  Map<String, dynamic> toJson() {
    final data = {
      'userId': userId,
      'phoneNumber': phoneNumber,
      'description': description,
      'profilePicture': profilePicture,
      'taxId': taxId,
      'faxId': faxId,
      'address': address,
      'mobile': mobile,
      'office': office,
    };

    return data;
  }
}
