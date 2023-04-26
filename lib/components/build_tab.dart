import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenger_app/screens/tabs/home_tab.dart';
import 'package:flutter_challenger_app/screens/tabs/restricted_tab.dart';

class TabContent {
  static Widget buildTabContent(int index) {
    bool isEmailVerified =
        FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    switch (index) {
      case 0:
        // Conteúdo da primeira aba (Home)
        return const HomeTab();
      case 1:

        // Conteúdo da segunda aba (Área Restrita, caso e-mail seja verificado)
        if (isEmailVerified) {
          return const RestrictedTab();
        } else {
          // Se o e-mail não estiver confirmado, exibe uma mensagem ou redireciona para outra tela
          return const SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Para acessar a Área Restrita por favor valide o seu e-mail em configurações',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
      default:
        return const HomeTab();
    }
  }
}

//enviar e-mail de verificação
void verificationEmail() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    if (!user.emailVerified) {
      await user.sendEmailVerification().then((value) => emailSent);
    } else {
      unknowError;
    }
  }
}

void emailSent(BuildContext context) {
  const snackbar = SnackBar(
    content: Text('E-mail de confirmação enviado'),
    duration: Duration(seconds: 3), // Duração do Snackbar em segundos
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void unknowError(BuildContext context) {
  const snackbar = SnackBar(
    content: Text('Error desconhecido'),
    duration: Duration(seconds: 3), // Duração do Snackbar em segundos
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
