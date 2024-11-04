import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notetaker/providers/category_provider.dart';
import 'package:notetaker/providers/note_provider.dart';
import 'package:notetaker/widgets/add_category.dart';

class CategoryModal extends ConsumerStatefulWidget {
  const CategoryModal({super.key, required this.id, required this.onTag});

  final String id;
  final Function() onTag;

  @override
  ConsumerState<CategoryModal> createState() {
    return _CategoryModalState();
  }
}

class _CategoryModalState extends ConsumerState<CategoryModal> {
  String _category = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ref.watch(categoryProvider);

    return Container(
      height: 550,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Category',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(FeatherIcons.xCircle))
              ],
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AddCategory(),
                    ...categories.map(
                      (category) => InkWell(
                        onTap: () {
                          print(category);
                          print(widget.id);
                          setState(() {
                            _category = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(171, 181, 189, 1),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                              ),
                              if (_category.toLowerCase() ==
                                  category.toLowerCase())
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.black,
                                )
                              else
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.grey[400],
                                )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: SizedBox(
              width: double.infinity, // Makes button take full width

              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(notesProvider.notifier)
                      .setCategory(widget.id, _category);
                  widget.onTag();

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
