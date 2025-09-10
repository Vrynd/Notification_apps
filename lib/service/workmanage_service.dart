import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notification_app/service/http_service.dart';
import 'package:notification_app/static/my_workmanager.dart';
import 'package:workmanager/workmanager.dart';

// Callback dispatcher
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Control flow
    if (task == MyWorkManager.oneOff.taskName ||
        task == MyWorkManager.oneOff.uniqueName) {
      debugPrint("input data $inputData");
    } else if (task == MyWorkManager.periodic.taskName) {
      int randomNumber = Random().nextInt(100);
      final httpService = HttpService();
      final result = await httpService.getDataFromUrl(
          "https://jsonplaceholder.typicode.com/posts/$randomNumber");
      debugPrint(
        "periodic task result $result",
      );
    }
    return Future.value(true);
  });
}

class WorkmanageService {
  // Constructor
  final Workmanager _workmanager;
  WorkmanageService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  // Initialize Workmanager
  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher);
  }

  // Trigger One Off Task
  Future<void> runOneOffTask() async {
    await _workmanager.registerOneOffTask(
        MyWorkManager.oneOff.uniqueName, MyWorkManager.oneOff.taskName,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        initialDelay: const Duration(seconds: 5),
        inputData: {
          "data": "This is a valid payload from oneoff task workmanager",
        });
  }

  // Trigger Periodic Task
  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
        MyWorkManager.periodic.uniqueName, MyWorkManager.periodic.taskName,
        frequency: const Duration(minutes: 16),
        initialDelay: Duration.zero,
        inputData: {
          "data": "This is a valid payload from periodic task workmanager",
        });
  }

  // Cancel All Tasks Service
  Future<void> cancelAllTasks() async {
    await _workmanager.cancelAll();
  }
}
