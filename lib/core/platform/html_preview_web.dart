import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

class HtmlPreview extends StatefulWidget {
  final String html;
  const HtmlPreview({super.key, required this.html});

  @override
  State<HtmlPreview> createState() => _HtmlPreviewState();
}

class _HtmlPreviewState extends State<HtmlPreview> {
  static int _counter = 0;
  late final String _viewType = 'html-preview-${_counter++}';
  late final web.HTMLIFrameElement _iframe = web.HTMLIFrameElement()
    ..style.border = 'none'
    ..style.width = '100%'
    ..style.height = '100%'
    ..style.backgroundColor = 'white';

  @override
  void initState() {
    super.initState();
    _iframe.srcdoc = _page(widget.html).toJS;
    ui_web.platformViewRegistry
        .registerViewFactory(_viewType, (int _) => _iframe);
  }

  @override
  void didUpdateWidget(covariant HtmlPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.html != widget.html) {
      _iframe.srcdoc = _page(widget.html).toJS;
    }
  }

  String _page(String body) =>
      '<!doctype html><html><head><meta charset="utf-8"></head>'
      '<body style="margin:0;font-family:Times New Roman,serif">$body</body>'
      '</html>';

  @override
  Widget build(BuildContext context) => HtmlElementView(viewType: _viewType);
}
