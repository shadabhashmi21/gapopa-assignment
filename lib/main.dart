import 'package:flutter/material.dart';
import 'package:gapopa_assignment/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
      title: 'Gapopa Assignment',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
}