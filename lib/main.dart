import 'package:adviser/application/advicer/advicer_bloc.dart';
import 'package:adviser/presentation/advicer/widgets/advicer_page.dart';
import 'package:adviser/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advicer App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: BlocProvider(
          create: (BuildContext context) => AdvicerBloc(),
          child: const AdvicerPage()),
    );
  }
}
