class Note {
  Note({
    required this.title,
    required this.note,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.isTagged = false,
  });

  final String title;
  final String note;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isTagged;
}
