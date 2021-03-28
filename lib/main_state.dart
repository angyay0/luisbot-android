import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'main_screen.dart';

/**
 * This State shows how to implement loading from local string
 * Improvements, this could receive the key from an api call
 */
class MyHomePageState extends State<MyHomePage> {
  String kBasicTemplate = '''
    <!DOCTYPE html><html>
    <head><title>QnA Bot</title></head>
    <body>
    <p>QnA Bot Created for Flutter</p><br/>
    <iframe src='https://webchat.botframework.com/embed/mobile-app-bot?s={BOT_KEY_PLEASE}'  style='min-width: 400px; width: 100%; min-height: 500px;'></iframe>
    </body>
    </html>
    ''';

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebView(
      initialUrl: 'https://flutter.dev',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) async {
        await loadFromString(kBasicTemplate, webViewController);
      },
    ));
  }

  /*
   * Loading bot from a local string, this could be an embedded site
   */
  Future<void> loadFromString(String sourceHtml, controller) async {
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(sourceHtml));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }
}
