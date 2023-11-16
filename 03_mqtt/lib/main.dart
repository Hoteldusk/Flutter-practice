import 'package:flutter/material.dart';
import 'package:mqtt/feature/notification.dart';
import 'package:mqtt/mqtt/state/mqtt_app_state.dart';
import 'package:mqtt/widgets/mqtt_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => MQTTAppState()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MQTTView(),
      ),
    );
  }
}
