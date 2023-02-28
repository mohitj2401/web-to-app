import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebToApp extends StatefulWidget {
  const WebToApp({super.key});

  @override
  State<WebToApp> createState() => _WebToAppState();
}

class _WebToAppState extends State<WebToApp> {
  late final WebViewController _controller;
  double _progress = 0.0;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_progress != 1)
            ProgressBar(
              value: _progress,
              //specify only one: color or gradient
              //color:Colors.red,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellowAccent, Colors.deepOrange],
              ),
            ),
        ],
      )),
    );
  }
}
