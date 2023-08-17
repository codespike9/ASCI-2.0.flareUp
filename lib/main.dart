import 'package:flutter/material.dart';
import 'package:flutter_flareup/Start-Screen/start_screen.dart';
import 'package:flutter_flareup/routes.dart';
import 'package:flutter_flareup/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flareUp',
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const StartScreen(),
    );
  }
}
