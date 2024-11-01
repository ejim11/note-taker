import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList(
      {super.key,
      required this.categories,
      required this.chosenCategory,
      required this.onChoseCategory});

  final List<String> categories;
  final String chosenCategory;
  final Function onChoseCategory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...categories.map(
            (category) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  onChoseCategory(category);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: category == chosenCategory
                        ? Colors.black
                        : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      color: const Color.fromRGBO(171, 181, 189, 1),
                    ),
                  ),
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: category != chosenCategory
                              ? Colors.black
                              : Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
