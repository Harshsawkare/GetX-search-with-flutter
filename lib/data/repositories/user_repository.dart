import 'package:flutter/cupertino.dart';
import 'package:girman_search/data/local/user_data_local.dart';
import 'package:girman_search/data/remote/user_data_remote.dart';
import 'package:girman_search/utility/internet_connection.dart';

import '../models/user_model.dart'; // Importing User model

class UserRepository {
  final UserDataLocal _localData = UserDataLocal(); // Instance of UserDataLocal for fetching local data
  final UserDataRemote _remoteData = UserDataRemote(); // Instance of UserDataRemote for fetching remote data

  /// Fetches user data either from remote or local source based on internet connectivity
  Future<List<User>> fetchUserData({String? query}) async {
    // Check if there is an active internet connection
    if (await InternetConnectivity().isConnected()) {
      debugPrint('Fetching user data from remote'); // Log to console
      // Fetch data from remote source
      return _remoteData.fetchRemoteData(query: query);
    } else {
      debugPrint('Fetching user data from local'); // Log to console
      // Fetch data from local source
      return _localData.fetchLocalData(query: query);
    }
  }
}
