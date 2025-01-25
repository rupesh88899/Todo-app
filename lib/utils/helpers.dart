import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/data.dart';
import 'package:todo/providers/date_provider.dart';

class Helpers {
  Helpers._();

  static String timeToStirng(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      return DateFormat.jm().format(date);
    } catch (e) {
      return '12:00 pm';
    }
  }

//function helps to filter tasks by days
  static bool isTaskFromSelectedDate(Task task, DateTime selectDate) {
    final DateTime taskDate = _stringToDateTime(task.date);
    if (taskDate.year == selectDate.year &&
        taskDate.month == selectDate.month &&
        taskDate.day == selectDate.day) {
      return true;
    }

    return false;
  }

  //changes date from string to datetime type
  static DateTime _stringToDateTime(String dateString) {
    try {
      DateFormat format = DateFormat.yMMMd();
      return format.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

//to pick date using calender icon
  static void selectDate(BuildContext context, WidgetRef ref) async {
    final initialDate = ref.read(dateProvider);
    DateTime? pickeDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2099),
    );

    if (pickeDate != null) {
      //when the user choose the date we asign it here on our date provider
      ref.read(dateProvider.notifier).state = pickeDate;
    }
  }
}
