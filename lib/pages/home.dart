import 'package:flutter/material.dart';
import 'package:notetaker/widgets/add_note_btn.dart';
import 'package:notetaker/widgets/category_list.dart';
import 'package:notetaker/widgets/date_filter.dart';
import 'package:notetaker/widgets/home_header.dart';
import 'package:notetaker/widgets/notes_list.dart';
import 'package:notetaker/widgets/search.dart';

import '../models/date.dart';
import '../models/debouncer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _searchInputController = TextEditingController();

  final debouncer = Debouncer(const Duration(milliseconds: 1000));

  final List<String> categories = [
    'All',
    'Important',
    'Lecture Notes',
    'To-do list',
    'shopping list',
    'dairy'
  ];

  late Date _chosenDate;
  late String _chosenCategory;

  void setDate(Date date) {
    setState(() {
      _chosenDate = date;
    });
  }

  void setCategory(String category) {
    setState(() {
      _chosenCategory = category;
    });
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    int day = now.day;

    int weekday = now.weekday;
    super.initState();
    _chosenDate = Date(day: weekday, date: day);
    _chosenCategory = 'All';
  }

  @override
  void dispose() {
    super.dispose();
    _searchInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: safeAreaTopPadding, left: 20, right: 20),
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const HomeHeader(),
                  const SizedBox(
                    height: 3,
                  ),
                  Search(inputController: _searchInputController),
                  const SizedBox(
                    height: 25,
                  ),
                  DateFilter(chosenDate: _chosenDate, onSetDate: setDate),
                  const SizedBox(
                    height: 25,
                  ),
                  CategoryList(
                      categories: categories,
                      chosenCategory: _chosenCategory,
                      onChoseCategory: setCategory),
                  const SizedBox(
                    height: 25,
                  ),
                  const NotesList()
                ],
              ),
            ),
            const AddNoteBtn()
          ],
        ),
      ),
    );
  }
}
