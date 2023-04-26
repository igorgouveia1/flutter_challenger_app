import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../components/custom_home_restricted_tab.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Ocorreu um erro ):');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemBuilder: ((context, index) {
              final document = documents[index];
              final grupoMuscular = document['grupo_muscular'];
              final nomeExercicio = document['nome_exercicio'];
              final repeticoes = document['repeticoes'];

              return CustomTileHomeRestricted(
                icone: const Icon(Icons.sports_gymnastics),
                subTitulo: grupoMuscular,
                titulo: nomeExercicio,
                trailing: '${repeticoes.toString()} Repetições',
              );
            }),
            itemCount: documents.length,
          );
        },
        stream: FirebaseFirestore.instance.collection('home').snapshots(),
      ),
    );
  }
}
