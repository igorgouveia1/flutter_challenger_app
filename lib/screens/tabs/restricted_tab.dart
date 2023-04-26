import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/custom_home_restricted_tab.dart';

class RestrictedTab extends StatelessWidget {
  const RestrictedTab({super.key});

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
              final peso = document['peso'];
              final altura = document['altura'];
              final semana = document['semana'];

              return CustomTileHomeRestricted(
                icone: const Icon(Icons.sports_gymnastics),
                titulo: '${peso.toString()} Kg',
                subTitulo: '${altura.toString()} cm',
                trailing: 'Semana ${semana.toString()}',
              );
            }),
            itemCount: documents.length,
          );
        },
        stream: FirebaseFirestore.instance.collection('restricted').snapshots(),
      ),
    );
  }
}
