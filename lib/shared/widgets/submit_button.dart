import 'package:flutter/material.dart';
import 'package:wedy/core/utils/extensions/extensions.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, this.label, required this.onPressed, this.loading = false});

  final String? label;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: 14.r,
          color: (onPressed == null || loading) ? Color(0xFFFFF0E3) : Color(0xFFFFAE66),
        ),
        child: Center(
          child: loading
              ? AspectRatio(aspectRatio: 1, child: CircularProgressIndicator())
              : Text(
                  label ?? "Tasdiqlash",
                  style: TextStyle(
                    color: onPressed == null ? Color(0xFFDABEA5) : Colors.white,
                    fontFamily: "SFProHeavy",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
