import 'package:flutter/material.dart';
import 'package:wedy/core/utils/extensions/extensions.dart';
import 'package:wedy/core/utils/validators/validators.dart';
import 'package:wedy/features/authentication/views/widgets/authentication_input_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.fullnameController,
    required this.loginController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController fullnameController;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthenticationInputField(
            label: "Ism Familya",
            hint: "Falonchi Fistonchi",
            validator: FullNameValidator.validator,
            controller: fullnameController,
          ),
          10.h,
          AuthenticationInputField(
            label: "Login",
            hint: "+998901234567 yoki email@example.com",
            validator: LoginValidator.validator,
            controller: loginController,
          ),
          10.h,
          AuthenticationInputField(
            label: "Parol",
            hint: "Parol kiriting",
            validator: PasswordValidator.validator,
            controller: passwordController,
            obscure: true,
          ),
          10.h,
          AuthenticationInputField(
            label: "Parolni tasdiqlash",
            hint: "Parol qayta kiriting",
            validator: (value) => ConfirmPasswordValidator.validator(value, passwordController.text.trim()),
            controller: confirmPasswordController,
            obscure: true,
          ),
        ],
      ),
    );
  }
}
