import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/providers/category_provider.dart';
import 'package:notetaker/widgets/add_note_btn.dart';
import 'package:notetaker/widgets/category_list.dart';
import 'package:notetaker/widgets/date_filter.dart';
import 'package:notetaker/widgets/home_header.dart';
import 'package:notetaker/widgets/notes_list.dart';
import 'package:notetaker/widgets/search.dart';

import '../models/date.dart';
import '../models/debouncer.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends ConsumerState<Home> {
  final _searchInputController = TextEditingController();

  final debouncer = Debouncer(const Duration(milliseconds: 1000));

  late Date _chosenDate;
  late String _chosenCategory;
  late String _searchText;

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

  void _onChangeSearchText(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    int day = now.day;
    int weekday = now.weekday;
    int month = now.month;
    int year = now.year;

    _chosenDate = Date(day: weekday, date: day, month: month, year: year);
    _chosenCategory = 'All';
    _searchText = "";

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ref.watch(categoryProvider);

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
                  Search(
                      inputController: _searchInputController,
                      onChangeText: _onChangeSearchText),
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
                  NotesList(
                    chosenCategory: _chosenCategory,
                    chosenDate: _chosenDate,
                    searchText: _searchText,
                  )
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
