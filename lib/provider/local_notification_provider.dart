import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_app/service/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  // Request Permission
  Future<void> requestPermission() async {
    _permission = await flutterNotificationService.requestPermission();
    notifyListeners();
  }

  // Aksi Pending Notification
  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
        await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
  }

  // Candel Notification
  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
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

  // Show Notification dengan gambar
  void showBigPictureNotification() {
    _notificationId += 1;
    flutterNotificationService.showBigPictureNotification(
      id: _notificationId,
      title: "New Big Picture Notification",
      body: "This is a new big picture notification with id $_notificationId",
      payload:
          "This is a payload from big picture notification with id $_notificationId",
    );
  }

  // Show Notification dengan schedule
  void scheduleDailyTenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyTenAMNotification(
      id: _notificationId,
    );
  }
}
