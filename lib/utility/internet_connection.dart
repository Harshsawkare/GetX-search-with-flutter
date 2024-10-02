import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  // Function to check current connectivity status
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return await Connectivity().checkConnectivity();
  }

  // Function to check if there is internet connection
  Future<bool> isConnected() async {
    var connectivityResult = await checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile)  ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }
}
