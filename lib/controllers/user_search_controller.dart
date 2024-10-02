import 'package:get/get.dart';
import 'package:girman_search/data/models/user_model.dart';
import 'package:girman_search/data/repositories/user_repository.dart';

class UserSearchController extends GetxController {
  var searchText = ''.obs; // Observable variable to hold the search text input
  var allItems = <User>[].obs; // Observable list to store all user items
  var filteredItems = <User>[]
      .obs; // Observable list to store filtered user items based on search input

  var isSearchActivated =
      false.obs; // Indicates if the search functionality is activated
  var isLoading = false.obs; // Indicates if data is currently being loaded

  @override
  void onInit() {
    super.onInit(); // Call the parent class's onInit method
    loadInitialData(); // Load initial user data when the controller is initialized

    // Listen for changes in the searchText observable
    searchText.listen((query) {
      // If the search query is empty, reload initial data
      if (query.isEmpty) {
        loadInitialData();
      } else {
        // Otherwise, load the search results based on the query
        loadSearchData(query);
      }
    });
  }

  // Updates the search text from the TextField input
  void updateSearchText(String value) {
    isSearchActivated.value = true; // Set search activation to true
    searchText.value = value; // Update the search text with the new value
  }

  // Loads the initial data from the user repository
  void loadInitialData() async {
    var list = await UserRepository()
        .fetchUserData(); // Fetch user data from the repository
    allItems.assignAll(list); // Assign fetched data to allItems
    filteredItems
        .assignAll(allItems); // Initially, all items are also filtered items
  }

  // Loads data based on the search query
  void loadSearchData(String query) async {
    isLoading.value = true; // Set loading state to true
    var list = await UserRepository().fetchUserData(
        query: query); // Fetch filtered user data based on the query
    filteredItems.assignAll(list); // Assign fetched data to filteredItems
    isLoading.value = false; // Set loading state to false after data is loaded
  }
}
