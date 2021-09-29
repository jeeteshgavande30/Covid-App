import 'package:corona_app/Screens/navigation_screen.dart';
import 'package:corona_app/Widgets/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => NavigationScreen(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
