import 'package:flutter/material.dart';
import 'package:proyecto/homepage.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/loading_screen.dart';
import 'package:proyecto/providers/main_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: MaterialApp(
        home: const MyLoadingScreen(
          child: Homepage(),
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
