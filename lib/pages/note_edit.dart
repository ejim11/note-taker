import 'dart:convert';
import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notetaker/widgets/category_modal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:remix_icon_icons/remix_icon_icons.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit(
      {super.key,
      required this.title,
      required this.content,
      required this.controller,
      this.category,
      required this.id});

  final String id;
  final String title;
  final String content;
  final QuillController controller;
  final String? category;

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  // QuillController _controller = QuillController.basic();

  bool _isDirty = false;
  // final FocusNode _editorFocusNode = FocusNode();
  bool _isEditable = false;

  bool _tagged = false;

  void _tagNote() {
    setState(() {
      _tagged = true;
    });
  }

  @override
  void didUpdateWidget(NoteEdit oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Similar to useEffect(() => {}, [dependency])
    // Runs when widget updates
  }

  @override
  void initState() {
    super.initState();

    // Listen for changes to track if document is dirty
    widget.controller.document.changes.listen((event) {
      setState(() {
        _isDirty = true;
      });
    });
  }

  // Save document to local storage
  Future<void> _saveDocument() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'document_$timestamp.json';
      final file = File('${directory.path}/$fileName');
      // String content = widget.controller.document.toPlainText().trim();

      // Convert document to JSON
      final json = jsonEncode(widget.controller.document.toDelta().toJson());
      await file.writeAsString(json);

      setState(() {
        _isDirty = false;
        _isEditable = false;
      });

      _displayScaffoldMessenger('Document saved successfully');
    } catch (e) {
      _displayScaffoldMessenger('Error saving document: $e');
    }
  }

  void _displayScaffoldMessenger(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  // Share document
  Future<void> _shareDocument() async {
    try {
      // Create temporary file
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempFile = File('${directory.path}/share_$timestamp.txt');

      // Save as plain text for sharing
      await tempFile.writeAsString(widget.controller.document.toPlainText());

      // Share the file
      await Share.share(
        tempFile.path,
        subject: 'Text Document',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing document: $e')),
      );
    }
  }

  Future<void> _exportAsPDF() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final pdfFile = File('${directory.path}/document_$timestamp.pdf');

      // Convert to PDF using pdf package (implementation depends on your needs)
      // This is a placeholder for PDF conversion logic

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF exported successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error exporting PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    void openHashtagModal() {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => CategoryModal(id: widget.id, onTag: _tagNote),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          if (!_isEditable)
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(FeatherIcons.edit),
              onPressed: () {
                setState(() {
                  _isEditable = true;
                });
              },
            ),
          IconButton(
            onPressed: openHashtagModal,
            icon: Icon(
              size: 20,
              BootstrapIcons.pin_angle_fill,
              color: widget.category != null || _tagged
                  ? Colors.yellow
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              size: 20,
              RemixIcon.delete_bin,
              color: Colors.red[200],
            ),
          ),
          // Save button with indicator
          if (_isEditable)
            IconButton(
              icon: Icon(
                Icons.save,
                color: _isDirty
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: _saveDocument,
            ),
          // Share button
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareDocument,
          ),
          // IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.logOut)),
        ],
      ),
      body: Column(
        children: [
          if (_isEditable)
            QuillSimpleToolbar(
              controller: widget.controller,
              configurations: const QuillSimpleToolbarConfigurations(
                showAlignmentButtons: true,
                showBackgroundColorButton: true,
                showClearFormat: true,
                showColorButton: true,
                showUndo: true,
                showRedo: true,
              ),
            ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.all(8),
              child: AbsorbPointer(
                absorbing: !_isEditable,
                child: QuillEditor(
                  controller: widget.controller,
                  focusNode: FocusNode(),
                  configurations: const QuillEditorConfigurations(
                    autoFocus: false,
                    expands: false,
                    padding: EdgeInsets.zero,
                    scrollable: true,
                  ),
                  scrollController: ScrollController(),
                ),
              ),
            ),
          ),
          if (_isDirty) // Show save reminder if document is unsaved
            Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.orange),
                  const SizedBox(width: 8),
                  const Text('Unsaved changes'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('SAVE NOW'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
