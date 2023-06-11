import 'package:flutter/material.dart';

class SizedBoxComponentHeight extends StatelessWidget {
  final double height;

  const SizedBoxComponentHeight({Key? key, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class SizedBoxComponentWidth extends StatelessWidget {
  final double width;

  const SizedBoxComponentWidth({Key? key, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
