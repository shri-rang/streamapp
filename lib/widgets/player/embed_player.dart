import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmbedPlayer extends StatefulWidget {
  final String url;
  const EmbedPlayer({required this.url, super.key});

  @override
  State<EmbedPlayer> createState() => _EmbedPlayerState();
}

class _EmbedPlayerState extends State<EmbedPlayer> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

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
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        javascriptChannels: <JavascriptChannel>{
          //_toasterJavascriptChannel(context),
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
