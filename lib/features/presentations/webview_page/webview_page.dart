import 'package:baby_tracker_app/features/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  double currentProgress = 0;
  bool isLoading =
      true; // Ekledik: Sayfanın yüklenip yüklenmediğini takip eder.

  void setWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              currentProgress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              currentProgress = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              currentProgress = 1;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void initState() {
    super.initState();
    setWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View'),
      ),
      body: Column(
        children: [
          currentProgress == 1
              ? const SizedBox.shrink()
              : LinearProgressIndicator(
                  color: Colors.white,
                  value: currentProgress,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      ColorConstant.primaryColor),
                ),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
