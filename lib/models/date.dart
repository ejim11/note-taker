class Date {
  Date(
      {required this.day,
      required this.date,
      required this.month,
      required this.year});

  final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  final int day;
  final int date;
  final int month;
  final int year;

  String getDay() {
    return days[day - 1];
  }
}
