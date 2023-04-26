import 'package:flutter/material.dart';
import 'package:flutter_challenger_app/src/shared/schemes/color_schemes.g.dart';

class CustomButton extends StatelessWidget {
  final Function()? onClick;
  final String text;
  const CustomButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        foregroundColor: MaterialStateProperty.all(lightColorScheme.background),
        backgroundColor:
            MaterialStateProperty.all(lightColorScheme.primaryContainer),
      ),
      child: Text(text),
    );
  }
}
