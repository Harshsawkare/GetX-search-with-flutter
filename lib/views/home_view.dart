import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:girman_search/controllers/user_search_controller.dart';
import 'package:girman_search/utility/theme.dart';
import 'package:girman_search/widgets/search_box.dart';
import 'package:girman_search/widgets/user_card.dart';

import '../controllers/appbar_menu_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // Initializing controllers for menu and search
  final AppbarMenuController menuController = Get.put(AppbarMenuController());
  final UserSearchController searchController = Get.put(UserSearchController());

  // Scroll controller for managing scrolling in the user list view
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Set the initial selected option in the AppBar menu
    menuController.updateSelected('Search');

    return GestureDetector(
      // Dismiss the keyboard when tapping outside the text field
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorTheme.primaryLogo,
          surfaceTintColor: Colors.transparent,
          elevation: 5, // Shadow elevation
          shadowColor: Colors.grey.withOpacity(0.5), // Shadow color
          title: Padding(
            padding: const EdgeInsets.only(left: 5),
            // Logo displayed in the AppBar
            child: Image.asset(
              'assets/logoSmall.png',
              width: 102.7,
            ),
          ),
          actions: [
            // Popup menu for selecting options
            PopupMenuButton<String>(
              onSelected: (value) {
                // Update the selected option in the menu controller
                menuController.updateSelected(value);
              },
              offset: const Offset(0, 50),
              icon: const Icon(Icons.menu),
              color: ColorTheme.primaryLogo,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: ColorTheme.border02, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              itemBuilder: (BuildContext context) {
                // Menu items to be displayed
                return [
                  PopupMenuItem<String>(
                    value: 'Search',
                    child: Obx(() => Text(
                      'SEARCH',
                      style: menuController.searchStyle.value,
                    )),
                  ),
                  PopupMenuItem<String>(
                    value: 'Website',
                    child: Obx(() => Text(
                      'WEBSITE',
                      style: menuController.websiteStyle.value,
                    )),
                  ),
                  PopupMenuItem<String>(
                    value: 'LinkedIn',
                    child: Obx(() => Text(
                      'LINKEDIN',
                      style: menuController.linkedInStyle.value,
                    )),
                  ),
                  PopupMenuItem<String>(
                    value: 'Contact',
                    child: Obx(() => Text(
                      'CONTACT',
                      style: menuController.contactStyle.value, // Reactive text style
                    )),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          width: Get.width, // Set width to screen width
          height: Get.height, // Set height to screen height
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [0, 0.3, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorTheme.primaryLogo,
                  ColorTheme.primaryLogo,
                  ColorTheme.secondaryLogo,
                ],
              )),
          child: Obx(() {
            // Reactive builder to rebuild on state changes
            return Column(
              children: [
                // Display brand logo based on search state
                searchController.isSearchActivated.value
                    ? const SizedBox(
                  height: 35,
                )
                    : Padding(
                  padding: const EdgeInsets.only(top: 109, bottom: 28),
                  child: Image.asset(
                    'assets/logoLarge.png',
                    width: 338,
                  ),
                ),

                // Search box widget
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                      searchController.isSearchActivated.value ? 50 : 25), // Padding based on search state
                  child: SearchBox(searchController: searchController), // Pass the search controller to the search box
                ),

                // User list view
                Expanded(
                  child: Obx(() {
                    // Loading state for user list
                    if (searchController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // No results found state
                    else if (searchController.filteredItems.isEmpty &&
                        searchController.isSearchActivated.value) {
                      return Center(
                          child: Image.asset(
                            'assets/noResultsFound.png',
                            width: 300,
                          ));
                    }
                    // If there are filtered items to display
                    else if (searchController.filteredItems.isNotEmpty &&
                        searchController.isSearchActivated.value) {
                      return NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            // Dismiss keyboard on scroll
                            if (scrollController.position.userScrollDirection ==
                                ScrollDirection.reverse ||
                                scrollController.position.userScrollDirection ==
                                    ScrollDirection.forward) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: searchController.filteredItems.length,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 50),
                                child: UserCard(
                                    user:
                                    searchController.filteredItems[index]),
                              );
                            },
                          ));
                    }
                    // If no conditions are met, return an empty widget
                    else {
                      return const SizedBox.shrink();
                    }
                  }),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}