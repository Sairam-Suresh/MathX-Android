import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class GrapherPage extends StatefulWidget {
  const GrapherPage({super.key});

  @override
  State<GrapherPage> createState() => _GrapherPageState();
}

class _GrapherPageState extends State<GrapherPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..loadRequest(Uri.parse("https://www.desmos.com/calculator"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Desmos Grapher")),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
