import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillStyledDisplay extends StatelessWidget {
  final QuillController controller;

  const QuillStyledDisplay({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: QuillEditor(
        controller: controller,
        scrollController: ScrollController(),
        focusNode: FocusNode(),
        configurations: const QuillEditorConfigurations(
          showCursor: false,
          padding: EdgeInsets.zero,
          scrollable: true,
          autoFocus: false,
          expands: false,

          // Customize styles for display

          // Add more custom styles as needed
        ),
      ),
    );
  }
}
