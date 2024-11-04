import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/models/date.dart';
import 'package:notetaker/providers/note_provider.dart';
import 'package:notetaker/widgets/note_item.dart';

class NotesList extends ConsumerStatefulWidget {
  const NotesList({
    super.key,
    required this.chosenCategory,
    required this.chosenDate,
    required this.searchText,
  });

  final String chosenCategory;
  final Date chosenDate;
  final String searchText;

  @override
  ConsumerState<NotesList> createState() {
    return _NotesListState();
  }
}

class _NotesListState extends ConsumerState<NotesList> {
  @override
  Widget build(BuildContext context) {
    final notes = ref
        .watch(notesProvider)
        .where((note) {
          bool areSameDate = widget.chosenDate.year == note.createdAt.year &&
              widget.chosenDate.month == note.createdAt.month &&
              widget.chosenDate.date == note.createdAt.day;

          if (areSameDate) return true;
          return false;
        })
        .toList()
        .where((note) {
          if (widget.chosenCategory == 'All') return true;
          if (note.category == widget.chosenCategory) return true;

          return false;
        })
        .toList()
        .where((note) {
          if (widget.searchText == '') return true;
          if (note.title
              .toLowerCase()
              .contains(widget.searchText.toLowerCase())) {
            return true;
          }
          return false;
        })
        .toList();

    if (notes.isNotEmpty) {
      print("cat");
      print(notes[0].category);
    }

    if (notes.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 150,
        child: Center(
          child: Text(
            'No Notes!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0, bottom: 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.05,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        // return Text(notes[index].title);
        return NoteItem(
          id: notes[index].id,
          title: notes[index].title,
          content: notes[index].note,
          index: index,
          category: notes[index].category,
        );
      },
    );
  }
}
