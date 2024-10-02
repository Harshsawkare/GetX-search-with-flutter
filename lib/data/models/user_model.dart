class User {
  final String firstName; // User's first name
  final String lastName;  // User's last name
  final String city;      // User's city
  final String contactNumber; // User's contact number

  // Constructor to initialize User object with required fields
  User({
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.contactNumber,
  });

  /// Factory constructor to create a User instance from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'], // Extract first name from JSON
      lastName: json['last_name'],    // Extract last name from JSON
      city: json['city'],              // Extract city from JSON
      contactNumber: json['contact_number'], // Extract contact number from JSON
    );
  }

  // Converts the User object into a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,        // Map first name to key
      'last_name': lastName,          // Map last name to key
      'city': city,                    // Map city to key
      'contact_number': contactNumber, // Map contact number to key
    };
  }
}
