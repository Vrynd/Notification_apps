import 'package:flutter/material.dart';
import 'package:notification_app/provider/local_notification_provider.dart';
import 'package:notification_app/provider/payload_provider.dart';
import 'package:notification_app/screens/detail_screen.dart';
import 'package:notification_app/screens/home_screen.dart';
import 'package:notification_app/service/http_service.dart';
import 'package:notification_app/service/local_notification_service.dart';
import 'package:notification_app/service/workmanage_service.dart';
import 'package:notification_app/static/my_route.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  String route = MyRoute.home.name;
  String? payload;

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final notificationResponse =
        notificationAppLaunchDetails!.notificationResponse;
    route = MyRoute.detail.name;
    payload = notificationResponse?.payload;
  }

  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => HttpService()),
      Provider(
          create: (context) => LocalNotificationService(
                context.read<HttpService>(),
              )
                ..init()
                ..configureLocalTimeZone()),
      ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
                context.read<LocalNotificationService>(),
              )..requestPermission()),
      ChangeNotifierProvider(
          create: (context) => PayloadProvider(payload: payload)),
      Provider(create: (context) => WorkmanageService()..init()),
    ],
    child: App(
      initialRoute: route,
    ),
  ));
}

class App extends StatelessWidget {
  final String initialRoute;

  const App({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        MyRoute.home.name: (context) => const HomeScreen(),
        MyRoute.detail.name: (context) => const DetailScreen(),
      },
    );
  }
}
