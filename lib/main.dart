import 'package:adviser/application/advicer/advicer_bloc.dart';
import 'package:adviser/presentation/advicer/widgets/advicer_page.dart';
import 'package:adviser/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart' as depedencyinjection;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // create all widgets if all dependencies are ready
  await depedencyinjection.init();

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
          create: (BuildContext context) =>
              depedencyinjection.serviceLocator<AdvicerBloc>(),
          child: const AdvicerPage()),
    );
  }
}
