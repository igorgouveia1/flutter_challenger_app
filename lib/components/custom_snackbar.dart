import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String snackBarText;
  const CustomSnackbar({super.key, required this.snackBarText});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(snackBarText),
    );
  }
}
