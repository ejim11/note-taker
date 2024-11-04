import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:notetaker/pages/note_edit.dart';
import 'package:notetaker/pages/styled_display.dart';

class NoteItem extends StatefulWidget {
  const NoteItem(
      {super.key,
      required this.id,
      required this.title,
      required this.content,
      required this.index,
      this.category});

  final String id;
  final String title;
  final String content;
  final int index;
  final String? category;

  @override
  State<NoteItem> createState() {
    return _NoteItemState();
  }
}

class _NoteItemState extends State<NoteItem> {
  QuillController _controller = QuillController.basic();

  @override
  void didUpdateWidget(NoteItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Similar to useEffect(() => {}, [dependency])
    // Runs when widget updates

    if (widget.content.isNotEmpty) {
      // Convert plain text to Delta
      final Delta delta = Delta()
        ..insert(widget.title)
        ..insert('\n')
        ..insert('\n')
        ..insert(widget.content)
        ..insert('\n');
      _controller = QuillController(
        document: Document.fromDelta(delta),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _controller = QuillController(
        document: Document(),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.content.isNotEmpty) {
      // Convert plain text to Delta
      final Delta delta = Delta()
        ..insert(widget.title)
        ..insert('\n')
        ..insert('\n')
        ..insert(widget.content)
        ..insert('\n');
      _controller = QuillController(
        document: Document.fromDelta(delta),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _controller = QuillController(
        document: Document(),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> cardColors = const [
      Color.fromRGBO(129, 151, 179, 1),
      Color.fromRGBO(189, 155, 179, 1),
      Color.fromRGBO(163, 162, 127, 1),
      Color.fromRGBO(150, 201, 168, 1),
      Color.fromRGBO(182, 180, 152, 1),
      Color.fromRGBO(188, 164, 192, 1),
      Color.fromRGBO(174, 189, 209, 1),
      Color.fromRGBO(218, 184, 191, 1)
    ];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => NoteEdit(
                id: widget.id,
                title: widget.title,
                content: widget.content,
                category: widget.category,
                controller: _controller),
          ),
        );
      },
      child: Card(
        color: cardColors[widget.index % 8],
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: QuillStyledDisplay(controller: _controller)),
            if (widget.category != null)
              const Positioned(
                right: 10,
                top: 10,
                child: Icon(
                  size: 15,
                  BootstrapIcons.pin_angle_fill,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
