import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final senhaConfirmadaController = TextEditingController();
  File? _selfie;
  UploadTask? _uploadselfie;

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Caso senha esteja confirmada, realiza o cadastro.
    try {
      if (senhaController.text == senhaConfirmadaController.text &&
          nomeController.text.isNotEmpty &&
          _selfie != null) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: senhaController.text,
        );
        uploadSelfie();
        signUpdata(nomeController.text, _selfie!.uri.path, emailController.text)
            .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cadastro Realizado com sucesso!'),
                ),
              ),
            )
            .then(
              (value) => Navigator.pushReplacementNamed(context, '/'),
            );
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preencha todos os campos corretamente'),
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);

      if (error.message ==
          'An unknown error occurred: FirebaseError: Firebase: The email address is already in use by another account. (auth/email-already-in-use).') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este E-mail já existe.'),
          ),
        );
        // } else if (error.code == 'wrong-password') {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('Senha incorreta'),
        //     ),
        //   );
      }
    }
  }

  //tirar a selfie
  Future<void> _pickImage() async {
    final takeSelfie = ImagePicker();
    final selfieResult = await takeSelfie.pickImage(source: ImageSource.camera);

    setState(() {
      if (selfieResult != null) {
        _selfie = File(selfieResult.path);
      }
    });
  }

  //salvando a selfie no firebase storage
  Future uploadSelfie() async {
    final path = 'selfie/${_selfie!.uri.path}';
    final file = File(_selfie!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    _uploadselfie = ref.putFile(file);
  }

// salvando informações adicionais do cadastro no banco.
  Future<void> signUpdata(String nome, String imageUrl, String email) async {
    await FirebaseFirestore.instance.collection('user').add({
      'nome': nome,
      'selfie': imageUrl, // Altera para a URL da imagem do Firebase Storage
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Cadastre sua selfie'),
                ),
                _selfie == null
                    ? InkWell(
                        child: const Icon(
                          Icons.photo_camera_outlined,
                          size: 36,
                        ),
                        onTap: () {
                          _pickImage();
                        },
                      )
                    : Image.file(
                        _selfie!,
                        width: 72,
                      ),
                CustomTextField(
                  label: 'Nome',
                  obscureText: false,
                  controller: nomeController,
                ),
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
                  label: ' Confirme a senha',
                  obscureText: true,
                  controller: senhaConfirmadaController,
                ),
                CustomButton(
                  text: 'Cadastrar',
                  onClick: signUp,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    child: const Text('Ou faça o login'),
                    onTap: () {
                      Navigator.pop(context);
                      //Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
