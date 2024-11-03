import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/providers/note_provider.dart';

class NotesList extends ConsumerWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    List<Color> cardColors = const [
      Color.fromRGBO(195, 220, 253, 1),
      Color.fromRGBO(255, 216, 244, 1),
      Color.fromRGBO(251, 246, 270, 1),
      Color.fromRGBO(176, 233, 196, 1),
      Color.fromRGBO(252, 250, 217, 1),
      Color.fromRGBO(241, 219, 245, 1),
      Color.fromRGBO(217, 232, 252, 1),
      Color.fromRGBO(255, 219, 227, 1)
    ];

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
        return Card(
          color: cardColors[index % 8],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notes[index].title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  notes[index].note,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 12),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
