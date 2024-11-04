import "package:uuid/uuid.dart";

const uuid = Uuid();

class Note {
  Note(
      {required this.title,
      required this.note,
      this.category,
      required this.createdAt,
      required this.updatedAt,
      String? id})
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final String note;
  String? category;
  final DateTime createdAt;
  final DateTime updatedAt;
}
