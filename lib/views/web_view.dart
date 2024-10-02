import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)  // Enable JavaScript
      ..loadRequest(Uri.parse(widget.url));  // Load the given URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Girman Technologies'),
      ),
      body: WebViewWidget(
        controller: _controller,  // Set the controller to the WebViewWidget
      ),
    );
  }
}
