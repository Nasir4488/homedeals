
class Favorite {
  final String userId;
  final String propertyId;

  Favorite({
    required this.userId,
    required this.propertyId,
  });

  /// Factory constructor for creating a new `Favorite` instance from a map.
  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      userId: json['userId'],
        propertyId: json['propertyId']
    );
  }

  /// Method to convert a `Favorite` instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'propertyId': propertyId,
    };
  }
}
