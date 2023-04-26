import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenger_app/screens/home.dart';
import 'package:flutter_challenger_app/screens/login.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // se o usuário estiver logado irá para home. Se não irá para a tela de login
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const LogIn();
          }
        },
      ),
    );
  }
}
