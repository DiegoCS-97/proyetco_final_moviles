import 'package:flutter/material.dart';
import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';

class PDFViewer extends StatefulWidget {
  final String url;
  final String name;
  PDFViewer({Key key, @required this.url, @required this.name}) : super(key: key);

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SimplePdfViewerWidget(
        initialUrl: widget.url,
      ),
    );
  }
}
