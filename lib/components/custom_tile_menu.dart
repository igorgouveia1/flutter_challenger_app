import 'package:flutter/material.dart';

class CustomTileMenu extends StatelessWidget {
  final Function()? onClick;
  final String menuTitle;
  const CustomTileMenu(
      {super.key, required this.menuTitle, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menuTitle),
      onTap: onClick,
    );
  }
}
