import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class WebScene extends StatefulWidget {
  final String url;
  final String? title;

  WebScene({required this.url, this.title});

  @override
  _WebSceneState createState() => _WebSceneState();
}

class _WebSceneState extends State<WebScene> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        title: Text(widget.title ?? '', style: TextStyle(color: Colors.black87)),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Share.share(this.widget.url);
            },
            child: Image.asset('img/icon_menu_share.png'),
          )
        ],
      ),
      body: WebViewWidget(controller: controller!),
    );
  }
}
