import 'package:flutter/material.dart';

Future showSnackBarComponent(BuildContext context, Widget content) async =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: content, backgroundColor: Colors.grey.shade700),
    );
