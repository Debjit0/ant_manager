import 'package:flutter/material.dart';

void nextPageOnly({Widget? page, BuildContext? context}) {
  Navigator.pushAndRemoveUntil(
      context!, MaterialPageRoute(builder: (_) => page!), (route) => false);
}

void nextPage({Widget? page, BuildContext? context}) {
  Navigator.push(context!, MaterialPageRoute(builder: (_) => page!));
}

void showAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}