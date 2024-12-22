import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Screen/Home/home_view.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(ChangeNotifierProvider.value(
    value: HomeViewModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
