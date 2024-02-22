import 'package:flutter/material.dart';

class ButtonAddTodo extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonAddTodo({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), // Span across the width
        ),
        child: const Text('Create new To-Do'),
      )
    );
  }
}