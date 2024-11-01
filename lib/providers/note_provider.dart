import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/data/notes.dart';
import 'package:notetaker/models/note.dart';

class NotesNotifier extends StateNotifier<List<Note>> {
  // setting the initial state data
  NotesNotifier() : super(notes);
}

final notesProvider =
    StateNotifierProvider<NotesNotifier, List<Note>>((ref) => NotesNotifier());
