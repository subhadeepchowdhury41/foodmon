import 'package:flutter/material.dart';

class FilledIconButton extends StatelessWidget {
  const FilledIconButton(
      {super.key, required this.onPressed, required this.icon});
  final Function() onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
