import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({Key? key, required this.url, required this.title})
      : super(key: key);

  final String url;
  final String title;

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (_) {
          if (widget.url.isEmpty) {
            return Center(
              child: Text('Homepage is empty'),
            );
          }
          return WebView(
            initialUrl: widget.url,
          );
        },
      ),
    );
  }
}
