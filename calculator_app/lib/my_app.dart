import 'package:calculator_app/view/calculator.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (const MaterialApp(
        debugShowCheckedModeBanner: false, home: Calculator()));
  }
}
