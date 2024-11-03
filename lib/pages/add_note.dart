import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/models/note.dart';
import 'package:notetaker/pages/home.dart';
import 'package:notetaker/providers/note_provider.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({super.key});

  @override
  ConsumerState<AddNote> createState() {
    return _AddNoteState();
  }
}

class _AddNoteState extends ConsumerState<AddNote> {
  final _formKey = GlobalKey<FormState>();

  final _enteredTitleController = TextEditingController();
  final _enteredContentController = TextEditingController();

  void _submitCreateNoteForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Note newNote = Note(
        title: _enteredTitleController.text,
        note: _enteredContentController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    ref.read(notesProvider.notifier).addNote(newNote);

    Navigator.of(context).pop();
  }

  void _discardNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const Home(),
      ),
    );
  }

  @override
  void dispose() {
    _enteredTitleController.dispose();
    _enteredContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // title
                TextFormField(
                  controller: _enteredTitleController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                  decoration: InputDecoration(
                    hintText: 'Coding exercises',
                    contentPadding: const EdgeInsets.all(15),
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(128, 128, 131, 1),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(
                      'Title',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1) {
                      return 'Please enter a title';
                    }
                    if (value.trim().length > 50) {
                      return 'Title must be at most 50 characters';
                    }
                    print(value);
                    return null;
                  },
                  // onChanged: (value) {
                  //   print(value);
                  // },
                  // onSaved: (value) {
                  //   setState(() {
                  //     _enteredName = value!;
                  //   });
                  // },
                ),
                const SizedBox(
                  height: 30,
                ),
                // content field
                TextFormField(
                  controller: _enteredContentController,
                  maxLines: 15,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                  decoration: InputDecoration(
                    hintText:
                        'Coding exercises are to be done before thursday...',
                    contentPadding: const EdgeInsets.all(15),
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(128, 128, 131, 1),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(
                      'Content',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1) {
                      return 'Please enter content for your note';
                    }

                    return null;
                  },
                  // onSaved: (value) {
                  //   _enteredEmail = value!;
                  // },
                ),
                const SizedBox(
                  height: 40,
                ),
                // save and discard btn
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitCreateNoteForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _discardNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                        child: const Text(
                          'Discard',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
