import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  void logout() async {
    FirebaseAuth.instance.signOut();
  }

  void changeLogin() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    User? currentUser = FirebaseAuth.instance.currentUser;
    // Caso senha esteja confirmada, realiza a alteração.
    try {
      if (senhaController.text == confirmarSenhaController.text) {
        await currentUser?.updateEmail(emailController.text);

        await currentUser
            ?.updatePassword(senhaController.text)
            .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cadastro alterado com sucesso.'),
                ),
              ),
            )
            .then(
              (value) => Navigator.pushReplacementNamed(context, '/'),
// Navegue para a tela de home
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dados incorretos.'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro desconhecido'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChallengerApp'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 64,
            ),
            const Text('Alterar dados cadastrais'),
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
            CustomTextField(
              label: 'Confirme a senha',
              obscureText: true,
              controller: confirmarSenhaController,
            ),
            CustomButton(
              text: 'Salvar',
              onClick: changeLogin,
            ),
          ],
        ),
      ),
    );
  }
}
