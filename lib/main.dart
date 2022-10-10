import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea_3_moviles/screens/home_page.dart';

import 'bloc/tarea3_bloc.dart';

void main() =>
    runApp(BlocProvider(create: (context) => Tarea3Bloc(), child: MyApp()));

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'tarea3',
        theme: ThemeData(colorScheme: const ColorScheme.light()),
        home: homePage());
  }
}
