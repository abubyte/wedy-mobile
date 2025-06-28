import 'package:flutter/material.dart';
import 'package:wedy/core/utils/extensions/extensions.dart';
import 'package:wedy/core/utils/validators/validators.dart';
import 'package:wedy/features/authentication/views/widgets/authentication_input_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.formKey, required this.loginController, required this.passwordController});

  final GlobalKey<FormState> formKey;
  
  final TextEditingController loginController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AuthenticationInputField(
            label: "Login",
            hint: "+998901234567 yoki email@example.com",
            validator: LoginValidator.validator,
            controller: widget.loginController,
          ),
          10.h,
          AuthenticationInputField(
            label: "Parol",
            hint: "Parol kiriting",
            validator: TextValidator.validator,
            controller: widget.passwordController,
            obscure: true,
          ),
        ],
      ),
    );
  }
}
