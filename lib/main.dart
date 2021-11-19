import 'package:adviser/application/advicer/advicer_bloc.dart';
import 'package:adviser/application/theme/theme_service.dart';
import 'package:adviser/presentation/advicer/widgets/advicer_page.dart';
import 'package:adviser/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as depedencyinjection;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // create all widgets if all dependencies are ready
  await depedencyinjection.init();
  await depedencyinjection.serviceLocator<ThemeService>().init();

  runApp(ChangeNotifierProvider(
    create: (context) => depedencyinjection.serviceLocator<ThemeService>(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Advicer App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: BlocProvider(
              create: (BuildContext context) =>
                  depedencyinjection.serviceLocator<AdvicerBloc>(),
              child: const AdvicerPage()));
    });
  }
}
