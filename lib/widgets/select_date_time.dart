import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo/providers/providers.dart';
import 'package:todo/widgets/widgets.dart';

import '../utils/utils.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //getting data and timefrom provider
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: 'Date',
            hintText: DateFormat.yMMMd().format(date),
            readOnly: true,
            surfixIcon: IconButton(
              onPressed: () => Helpers.selectDate(context, ref),
              icon: Icon(Icons.calendar_today_rounded),
            ),
          ),
        ),
        Gap(20),
        Expanded(
          child: CommonTextField(
            title: 'Time',
            hintText: Helpers.timeToStirng(time),
            readOnly: true,
            surfixIcon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: Icon(Icons.watch_later_outlined),
            ),
          ),
        ),
      ],
    );
  }

// to pick time using clock icon
  void _selectTime(BuildContext context, WidgetRef ref) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }
}
