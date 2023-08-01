import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 16.0,
      child: CircularProgressIndicator(),
    );
  }
}
