import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  final String url;
  late var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(K.appColor.mainBackgroundColor)
    ..loadRequest(Uri.parse(url));

  WebView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: K.appColor.mainBackgroundColor,
        foregroundColor: K.appColor.white,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
