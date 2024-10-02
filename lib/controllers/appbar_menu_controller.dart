import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:girman_search/utility/theme.dart';
import 'package:girman_search/views/web_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AppbarMenuController extends GetxController {
  // Reactive variables for body text and selected option
  var bodyText = 'Welcome to Girman Technologies'.obs;
  var selectedOption = ''.obs;

  // Text styles for selected options
  final selectedTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: ColorTheme.textBlue,
    decoration: TextDecoration.underline,
    decorationColor: ColorTheme.textBlue,
    decorationThickness: 2,
    height: 1.5,
  );

  // Separate text styles for each menu option
  var searchStyle = const TextStyle().obs;
  var websiteStyle = const TextStyle().obs;
  var linkedInStyle = const TextStyle().obs;
  var contactStyle = const TextStyle().obs;

  final defaultTextStyle = const TextStyle();

  /// Update the selected menu option and adjust the UI accordingly
  Future<void> updateSelected(String value) async {
    // Apply the selected style
    _applyStyle(value);

    // Update the body text based on selected option
    switch (value) {
      case 'Search':
        bodyText.value = 'You selected SEARCH';
        break;
      case 'Website':
        bodyText.value = 'You selected WEBSITE';
        await _navigateToWebView('https://www.girmantech.com/');
        break;
      case 'LinkedIn':
        bodyText.value = 'You selected LINKEDIN';
        await _navigateToWebView('https://www.linkedin.com/company/girmantech/');
        break;
      case 'Contact':
        bodyText.value = 'You selected CONTACT';
        await launchEmailApp();
        break;
      default:
        bodyText.value = 'Welcome to Girman Technologies';
    }
  }

  /// Launches the email app
  Future<void> launchEmailApp() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'contact@girmantech.com',
      query: 'subject=Flutter Assignment',
    );

    try {
      // Check if the email URI can be launched
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showSnackbar('Could not launch email app');
      }
    } catch (e) {
      debugPrint('Error launching email app: $e');
      _showSnackbar('Error launching email app');
    }
  }

  /// Navigates to a web view page
  Future<void> _navigateToWebView(String url) async {
    try {
      await Get.to(WebViewPage(url: url));
    } catch (e) {
      debugPrint('Error navigating to web view: $e');
      _showSnackbar('Could not open the web page');
    }
  }

  /// Applies the selected style to the appropriate option
  void _applyStyle(String selectedOption) {
    // Reset all styles to default
    searchStyle.value = defaultTextStyle;
    websiteStyle.value = defaultTextStyle;
    linkedInStyle.value = defaultTextStyle;
    contactStyle.value = defaultTextStyle;

    // Apply the selected style based on the chosen option
    switch (selectedOption) {
      case 'Search':
        searchStyle.value = selectedTextStyle;
        break;
      case 'Website':
        websiteStyle.value = selectedTextStyle;
        break;
      case 'LinkedIn':
        linkedInStyle.value = selectedTextStyle;
        break;
      case 'Contact':
        contactStyle.value = selectedTextStyle;
        break;
    }
  }

  /// Displays a snackbar with the provided message
  void _showSnackbar(String message) {
    Get.snackbar(
      'Error', // Title of the snackbar
      message, // Message to display
      snackPosition: SnackPosition.BOTTOM, // Position at the bottom
      duration: const Duration(seconds: 2), // Duration for the snackbar to be visible
    );
  }
}
