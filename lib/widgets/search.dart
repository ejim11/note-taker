import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

import '../models/debouncer.dart';

class Search extends StatelessWidget {
  Search(
      {super.key, required this.inputController, required this.onChangeText});

  final TextEditingController inputController;

  final Function(String text) onChangeText;

  final debouncer = Debouncer(const Duration(milliseconds: 1000));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(241, 243, 245, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextField(
        controller: inputController,
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            FeatherIcons.search,
            color: Color.fromRGBO(173, 181, 189, 1),
          ),
          hintText: 'Search for notes',
          hintStyle: TextStyle(
            color: Color.fromRGBO(173, 181, 189, 1),
          ),
        ),
        onChanged: (value) {
          if (inputController.text.isNotEmpty) {
            debouncer.run(() {
              onChangeText(value);
            });
          } else {
            onChangeText(value);
          }
        },
      ),
    );
  }
}
