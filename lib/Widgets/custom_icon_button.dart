import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final onpressed;
  final IconData icon;
  final color;
  CustomIconButton(this.onpressed, this.icon, {this.color = Colors.red});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var iconSize = width / 6;
    return IconButton(
        highlightColor: Colors.red,
        onPressed: onpressed,
        icon: Icon(
          icon,
          color: color,
        ),
        iconSize: iconSize);
  }
}

MainAxisAlignment rowAllignment = MainAxisAlignment.spaceEvenly;
