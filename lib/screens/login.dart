import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // realiza o login
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: senhaController.text,
          )
          .then(
            (value) => Navigator.pop(context),
          );
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      // erro de  usuário não encontrado
      if (error.message ==
          'An unknown error occurred: FirebaseError: Firebase: The email address is badly formatted. (auth/invalid-email).') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
          ),
        );
        // erro de senha incorreta
      } else if (error.message ==
          'An unknown error occurred: FirebaseError: Firebase: The password is invalid or the user does not have a password. (auth/wrong-password).') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha incorreta'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.login,
                size: 64,
              ),
              const Text('Entrar'),
              CustomTextField(
                label: 'E-mail',
                obscureText: false,
                controller: emailController,
              ),
              CustomTextField(
                label: 'Senha',
                obscureText: true,
                controller: senhaController,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  16,
                  16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //to do
                    Text('Esqueceu a senha?'),
                  ],
                ),
              ),
              CustomButton(
                text: 'Entrar',
                onClick: login,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: InkWell(
                  child: const Text('Ou cadastre-se'),
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
