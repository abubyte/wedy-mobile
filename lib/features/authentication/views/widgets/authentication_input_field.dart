import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:wedy/core/utils/extensions/extensions.dart';

class AuthenticationInputField extends StatefulWidget {
  const AuthenticationInputField({
    super.key,
    this.obscure = false,
    this.validator,
    required this.hint,
    this.label,
    required this.controller,
  });

  final bool obscure;
  final String? Function(String? value)? validator;
  final String? label;
  final String hint;
  final TextEditingController controller;

  @override
  State<AuthenticationInputField> createState() => _AuthenticationInputFieldState();
}

class _AuthenticationInputFieldState extends State<AuthenticationInputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(color: Color(0xFFDABEA5), fontWeight: FontWeight.w400, fontSize: 16),
          ),
          6.h,
        ],
        TextFormField(
          obscureText: widget.obscure ? _obscure : false,
          validator: widget.validator,
          controller: widget.controller,
          style: TextStyle(color: Color(0xFF816246), fontSize: 16, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            suffixIcon: widget.obscure
                ? IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: _obscure ? Icon(Feather.eye_off) : Icon(Feather.eye), // TODO: Use SVG icon from Figma file
                  )
                : null,
            filled: true,
            fillColor: Color(0xFFFFF9F4),
            hintText: widget.hint,
            hintStyle: TextStyle(color: Color(0xFFDABEA5), fontWeight: FontWeight.w400, fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: 14.r,
              borderSide: BorderSide(width: 2, color: Color(0xFFDABEA5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(width: 2, color: Color(0xFFDABEA5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(width: 2, color: Color(0xFFDABEA5)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(width: 2, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(width: 2, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
