import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notetaker/pages/styled_display.dart';

class QuillPreviewPage extends StatefulWidget {
  const QuillPreviewPage({
    super.key,
    required this.deltaJson,
    required this.title,
    required this.content,
  });

  final String deltaJson;
  final String title;
  final String content;

  @override
  State<QuillPreviewPage> createState() => _QuillPreviewPageState();
}

class _QuillPreviewPageState extends State<QuillPreviewPage> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.deltaJson)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.onPrimary,
        child: QuillStyledDisplay(controller: _controller),
      ),
    );
  }
}
