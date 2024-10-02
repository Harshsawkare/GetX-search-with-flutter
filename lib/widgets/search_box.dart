import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girman_search/controllers/user_search_controller.dart';
import 'package:girman_search/utility/theme.dart';

class SearchBox extends StatelessWidget {
  final UserSearchController searchController;
  const SearchBox({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        searchController.updateSearchText(value.toLowerCase()); // Update search text
      },
      style: const TextStyle(
        color: ColorTheme.textGrey01,
        fontSize: 16,
      ),
      cursorColor: ColorTheme.textGrey01,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: const TextStyle(
          color: ColorTheme.textGrey01,
          fontSize: 16,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 20,
          color: ColorTheme.textGrey01,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorTheme.border01,
            width: 1,
          ),
        ),
        focusColor: ColorTheme.border01,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorTheme.border01,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorTheme.border01, // Set the desired color
            width: 1,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
