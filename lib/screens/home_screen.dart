import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo/config/config.dart';
import 'package:todo/data/data.dart';
import 'package:todo/providers/providers.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
//this is for routing
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//watching providers
    final taskState = ref.watch(taskProvider);

//using function which is in last to filtere tasks completed/not
    final completedTasks = _completedTasks(taskState.tasks,ref);
    final incompletedTasks = _incompletedTasks(taskState.tasks,ref);
    final selectedDate = ref.watch(dateProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: context.deviceSize.height * 0.3,
                width: context.deviceSize.width,
                color: context.colorScheme.primary,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Helpers.selectDate(context, ref),
                        child: DisplayWhiteText(
                          text: DateFormat.yMMMd().format(selectedDate),
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                      DisplayWhiteText(
                        text: 'My Todo List',
                        fontSize: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            right: 0,
            left: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //tasks are not completed
                    DisplayListOfTasks(
                      tasks: incompletedTasks,
                    ),

                    Gap(20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineMedium,
                    ),
                    Gap(20),

                    //task are completed
                    DisplayListOfTasks(
                      tasks: completedTasks,
                      isCompletedTasks: true,
                    ),

                    Gap(20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary),
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: DisplayWhiteText(text: 'Add New task'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//completed tasks
  List<Task> _completedTasks(List<Task> tasks, WidgetRef ref) {
    final selectDate = ref.watch(dateProvider);
    final List<Task> filteredTasks = [];

    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectDate);
      if (task.isCompleted && isTaskDay) {
        if (isTaskDay) {
          filteredTasks.add(task);
        }
      }
    }
    return filteredTasks;
  }

//not completed tasks
  List<Task> _incompletedTasks(List<Task> tasks, WidgetRef ref) {
    final selectDate = ref.watch(dateProvider);
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectDate);
      //not completed tasks
      if (!task.isCompleted && isTaskDay) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
