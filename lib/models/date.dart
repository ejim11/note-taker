class Date {
  Date({required this.day, required this.date});

  final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  final int day;
  final int date;

  String getDay() {
    return days[day - 1];
  }
}
