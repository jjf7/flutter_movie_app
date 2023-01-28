import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => const HomeScreen(),
          'details': (BuildContext context) => const DetailsScreen(),
        },
        theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black87,
        )));
  }
}
