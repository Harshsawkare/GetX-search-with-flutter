import 'package:cloud_firestore/cloud_firestore.dart'; // Importing Firestore package for remote data fetching
import 'package:girman_search/data/local/user_data_local.dart'; // Importing local data fetching class

import '../models/user_model.dart'; // Importing User model

class UserDataRemote {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instance of Firestore for database operations

  /// Fetches user data from Firestore or local data as a fallback
  Future<List<User>> fetchRemoteData({String? query}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot; // Snapshot to hold the query results
    List<User> userData; // List to hold user data

    // Check if there's a query for filtering the user data
    if (query != null && query.isNotEmpty) {
      try {
        // Query Firestore for users matching the search term
        snapshot = await _firestore.collection('users')
            .where('search_term', isGreaterThanOrEqualTo: query) // Start of the search range
            .where('search_term', isLessThanOrEqualTo: '$query\uf8ff') // End of the search range
            .get();

        // If documents are found, map them to User objects
        if (snapshot.docs.isNotEmpty) {
          userData = snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
        } else {
          // If no documents are found, fallback to local data
          userData = await UserDataLocal().fetchLocalData(query: query);
        }
      } catch (e) {
        // If there's an error, fallback to local data
        userData = await UserDataLocal().fetchLocalData(query: query);
      }
    } else {
      try {
        // If no query is provided, fetch all user data from Firestore
        snapshot = await _firestore.collection('users').get();
        userData = snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
      } catch (e) {
        // If there's an error, fallback to local data
        userData = await UserDataLocal().fetchLocalData();
      }
    }

    // Return the list of User objects, either fetched from Firestore or local data
    return userData;
  }
}
