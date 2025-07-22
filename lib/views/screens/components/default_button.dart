import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.callback, required this.title});
  final VoidCallback callback;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector();
  }
}
