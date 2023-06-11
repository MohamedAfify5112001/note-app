import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int? maxLines;

  const TextComponent(
      {Key? key, required this.text, required this.style, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      style: style,
    );
  }
}
