import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wedy/config/di/injection.dart';
import 'package:wedy/config/routes/routes.dart';
import 'package:wedy/core/base/base_view.dart';
import 'package:wedy/core/utils/extensions/extensions.dart';
import 'package:wedy/core/utils/snackbars/snackbar.dart';
import 'package:wedy/features/authentication/viewmodels/authentication_bloc.dart';
import 'package:wedy/features/authentication/viewmodels/authentication_state.dart';
import 'package:wedy/features/authentication/views/register/widgets/register_form.dart';
import 'package:wedy/features/authentication/views/widgets/authentication_navigate_button.dart';
import 'package:wedy/shared/widgets/submit_button.dart';
import 'package:wedy/shared/widgets/welcome_text.dart';

class RegisterView extends BaseView<AuthenticationBloc> {
  const RegisterView({super.key});

  @override
  AuthenticationBloc createViewModel() => getIt<AuthenticationBloc>();

  @override
  Widget buildView(BuildContext context) {
    return const RegisterScreen();
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Space
                      70.h,

                      // Welcome Text
                      Center(child: WelcomeText()),
                      50.h,

                      // Register Form
                      RegisterForm(
                        formKey: _registerFormKey,
                        fullnameController: _fullnameController,
                        loginController: _loginController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),
                      12.h,

                      // Navigate Button
                      AuthenticationNavigateButton(
                        onPressed: () => context.push(Routes.login),
                        text: "Hisobingiz bormi?",
                      ),
                    ],
                  ),
                ),
              ),

              // Submit Button
              10.h,
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  bool loading = state.isLoading;
                  // if (state.status == AuthenticationStatus.unauthenticated && state.isAuthenticated) {
                  if (state.status == AuthenticationStatus.unauthenticated) {
                    state.isAuthenticated
                        ? ToastUi.showToast(message: "Hisob yaratildi!")
                        : ToastUi.showToast(message: "Hisob allaqachon yaratilgan. Iltimos hisobingizni tasdiqlang!");
                    context.pushReplacement(
                      Routes.verify,
                      extra: {'login': _loginController.text.trim(), 'password': _passwordController.text.trim()},
                    );
                  } else if (state.status == AuthenticationStatus.error) {
                    ToastUi.showError(message: state.errorMessage ?? "Hisob yaratib bo'lmadi");
                  }

                  if (state.status == AuthenticationStatus.loading) {
                    ToastUi.showToast(message: "Hisob yaratilmoqda...");
                    return SubmitButton(onPressed: null, loading: true);
                  } else {
                    return SubmitButton(
                      loading: loading,
                      onPressed: loading
                          ? null
                          : () {
                              if (_registerFormKey.currentState!.validate()) {
                                context.read<AuthenticationBloc>().register(
                                  _fullnameController.text.trim(),
                                  _loginController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              } else {
                                ToastUi.showError(message: "Iltimos ma'lumotlarni to'liq kiriting");
                              }
                            },
                    );
                  }
                },
              ),
              16.h,
            ],
          ),
        ),
      ),
    );
  }
}
