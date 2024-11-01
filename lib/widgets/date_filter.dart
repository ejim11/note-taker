import 'package:flutter/material.dart';
import 'package:notetaker/models/date.dart';

class DateFilter extends StatelessWidget {
  const DateFilter(
      {super.key, required this.chosenDate, required this.onSetDate});

  final Date chosenDate;
  final Function onSetDate;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> getDaysInMonth(int year, int month) {
      List<Map<String, dynamic>> days = [];
      DateTime firstDayOfMonth = DateTime(year, month, 1);
      int totalDays = DateTime(year, month + 1, 0).day;

      for (int i = 0; i < totalDays; i++) {
        DateTime currentDate = firstDayOfMonth.add(Duration(days: i));
        days.add({
          'day': currentDate.weekday,
          'date': currentDate.day,
        });
      }

      return days;
    }

    List<Date> days = getDaysInMonth(2024, 11)
        .map((day) => Date(day: day['day'], date: day['date']))
        .toList();

    bool isSameDate(int date) {
      return chosenDate.date == date;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...days.map(
            (day) => Container(
              margin: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  onSetDate(day);
                },
                child: Container(
                  width: 55,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSameDate(day.date) ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      color: const Color.fromRGBO(171, 181, 189, 1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        day.getDay(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isSameDate(day.date)
                                  ? const Color.fromRGBO(222, 226, 230, 1)
                                  : const Color.fromRGBO(73, 80, 87, 1),
                            ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${day.date}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: isSameDate(day.date)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ],
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
