import 'package:flutter/material.dart';

class CustomTileHomeRestricted extends StatelessWidget {
  final String titulo;
  final String subTitulo;
  final Widget icone;
  final String trailing;
  const CustomTileHomeRestricted(
      {super.key,
      required this.titulo,
      required this.subTitulo,
      required this.icone,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(titulo),
          subtitle: Text(subTitulo),
          leading: icone,
          trailing: Text(trailing),
        ),
      ),
    );
  }
}
