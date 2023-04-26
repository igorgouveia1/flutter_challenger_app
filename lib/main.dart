import 'package:flutter/material.dart';
import 'package:flutter_challenger_app/screens/firebase_auth.dart';
import 'package:flutter_challenger_app/screens/login.dart';
import 'package:flutter_challenger_app/screens/profile.dart';
import 'package:flutter_challenger_app/screens/sign_up.dart';
import 'package:flutter_challenger_app/src/shared/schemes/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ChallengerApp',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          scaffoldBackgroundColor: lightColorScheme.background,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: lightColorScheme.background,
              foregroundColor: lightColorScheme.onBackground),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: lightColorScheme.onPrimaryContainer,
              unselectedItemColor: lightColorScheme.onBackground,
              backgroundColor: lightColorScheme.background),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: darkColorScheme.background,
          colorScheme: darkColorScheme,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: darkColorScheme.background,
              foregroundColor: darkColorScheme.onBackground),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: darkColorScheme.onBackground,
              backgroundColor: darkColorScheme.background),
        ),
        routes: {
          '/': (context) => const Authentication(),
          '/login': (context) => const LogIn(),
          '/signup': (context) => const SignUp(),
          '/profile': (context) => const MyProfile(),
        });
  }
}
