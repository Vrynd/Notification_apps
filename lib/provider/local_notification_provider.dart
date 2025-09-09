import 'package:flutter/material.dart';
import 'package:notification_app/service/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  // Request Permission
  Future<void> requestPermission() async {
    _permission = await flutterNotificationService.requestPermission();
    notifyListeners();
  }

  // Show Notification
  void showNotification() {
    _notificationId += 1;
    flutterNotificationService.showNotification(
        id: _notificationId,
        title: "New Notification",
        body: "This is a new notification with id $_notificationId",
        payload:
            "This is a payload from notification with id $_notificationId");
  }
}
