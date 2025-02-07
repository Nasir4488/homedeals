class Country {
  final String country; // Country name
  final String? iso2;   // Two-letter country code
  final String? iso3;   // Three-letter country code
  final List<String> cities; // List of cities

  Country({
    required this.country,
    this.iso2,
    this.iso3,
    required this.cities,
  });

  // Factory method to create a Country from JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country: json['country'] as String,
      iso2: json['iso2'] as String?,
      iso3: json['iso3'] as String?,
      cities: List<String>.from(json['cities'] ?? []),
    );
  }

  // Method to convert a Country instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'iso2': iso2,
      'iso3': iso3,
      'cities': cities,
    };
  }
}
