import 'package:flutter/material.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({
    super.key,
    this.height = 50,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        // height: height,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
