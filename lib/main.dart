import 'package:flutter/material.dart';
import 'package:flutter_exam/ml.dart';
import 'package:flutter_exam/navbar.dart';
import 'first_page.dart';
import 'second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug yazısını gizle
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/ml',
      routes: {
        '/nav': (context) => const BottomNavBar(),
        '/': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return FirstPage(scannedText: args);
        },
        '/ml': (context) => const MlPage(),
        '/second': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return SecondPage(enteredText: args);
        },
      },
    );
  }
}
