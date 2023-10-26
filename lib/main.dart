// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/api_provider.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/screens/Search/screen.dart';
import 'package:weather/screens/Initial/screen.dart';
import 'package:weather/screens/Saved/screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiProvider>(
          create: (_) => ApiProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<ThemeProvider>(context, listen: false).initialize();
    Provider.of<ApiProvider>(context, listen: false).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 82, 200, 255)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InitialPage(),
        '/saved': (context) => SavedScreen(),
        '/add': (context) => SearchScreen(),
      },
    );
  }
}
