import 'package:flutter/material.dart';

class AuthenticationNavigateButton extends StatelessWidget {
  const AuthenticationNavigateButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Color(0xFFFF9E36), fontFamily: "SFProHeavy", fontSize: 18),
      ),
    );
  }
}
