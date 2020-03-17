import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_screen/tambola_ticket_screen.dart';

void main() {
  runApp(MyApp());
}
void config() {
  //print('inside config()');
  //set orientation to landscape throughout the application
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    config();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TambolaTicket(),
    );
  }
}
