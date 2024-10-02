import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/user_model.dart'; // Importing the User model

class UserDataLocal {
  /// Fetches user data from a local JSON file and optionally filters it based on a query
  Future<List<User>> fetchLocalData({String? query}) async {
    // Load the JSON string from the specified asset file
    final jsonString = await rootBundle.loadString('assets/users.json');

    // Decode the JSON string into a List of dynamic objects
    final List<dynamic> jsonData = jsonDecode(jsonString);

    // Map the JSON data to a List of User objects
    List<User> userData = jsonData.map((data) => User.fromJson(data)).toList();

    // If there's a query, filter the userData list based on the query
    if (query != null && query.isNotEmpty) {
      userData = userData.where((user) {
        // Check if any of the user's properties contain the query string (case-insensitive)
        return user.firstName.toLowerCase().contains(query.toLowerCase()) ||
            user.lastName.toLowerCase().contains(query.toLowerCase()) ||
            user.city.toLowerCase().contains(query.toLowerCase()) ||
            user.contactNumber.contains(query);
      }).toList(); // Convert the filtered iterable back to a List
    }

    // Return the list of User objects, either filtered or unfiltered
    return userData;
  }
}
