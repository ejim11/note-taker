import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notetaker/pages/home.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

// choosing a color scheme for light mode
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 253, 252, 255),
);

// choosing a color scheme for dark mode
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 7, 48, 59),
);

void main() {
  // This makes the orientation of the device to be fixed
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {});

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteTaker',
      // setting the dark theme
      darkTheme: ThemeData.dark().copyWith(
        // setting the color scheme for the dark theme
        colorScheme: kDarkColorScheme,
        textTheme: ThemeData().textTheme.copyWith(
              bodyMedium:
                  const TextStyle(color: Colors.white, fontFamily: 'Avenir'),
            ),
      ),
      // setting the defualt theme which is the light theme
      theme: ThemeData().copyWith(
        // setting the color scheme for the light theme
        colorScheme: kColorScheme,

        // settitng the text theme for light theme
        textTheme: ThemeData().textTheme.copyWith(
              bodyMedium:
                  const TextStyle(color: Colors.black, fontFamily: 'Avenir'),
            ),
      ),
      // choosing theme based of the systems theme
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}
