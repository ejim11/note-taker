import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/data/notes.dart';
import 'package:notetaker/models/note.dart';

class NotesNotifier extends StateNotifier<List<Note>> {
  // setting the initial state data
  NotesNotifier() : super(notes);

  void addNote(Note note) async {
    state = [note, ...state];
  }

  void filterNotes(String category) {
    final filteredNotes = state.where((note) {
      if (note.category == category) return true;

      return false;
    });

    state = [...filteredNotes];
  }

  void deleteNote(String id) {
    final filteredNotes = state.where((note) {
      if (note.id == id) return false;

      return true;
    });

    state = [...filteredNotes];
  }

  void setCategory(String id, String category) {
    final existingNoteIndex = state.indexWhere((note) {
      if (note.id == id) return true;
      return false;
    });

    state[existingNoteIndex].category = category;

    state = [...state];
  }
}

final notesProvider =
    StateNotifierProvider<NotesNotifier, List<Note>>((ref) => NotesNotifier());
