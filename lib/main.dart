import 'package:flutter/material.dart';
import 'package:foodfacts/home.dart';
import 'package:provider/provider.dart';

import './services/foodish_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: FoodishProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Food Facts',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          primaryColor: Colors.teal,
          accentColor: Colors.orange,
          brightness: Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Food Facts'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomeWidget();
  }
}
