import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:notetaker/pages/add_note.dart';

class AddNoteBtn extends StatelessWidget {
  const AddNoteBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const AddNote(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: const Icon(
            FeatherIcons.plus,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
