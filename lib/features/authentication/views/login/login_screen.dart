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
import 'package:wedy/features/authentication/views/widgets/authentication_navigate_button.dart';
import 'package:wedy/features/authentication/views/login/widgets/login_form.dart';
import 'package:wedy/shared/widgets/submit_button.dart';
import 'package:wedy/shared/widgets/welcome_text.dart';

class LoginView extends BaseView<AuthenticationBloc> {
  const LoginView({super.key});

  @override
  AuthenticationBloc createViewModel() => getIt<AuthenticationBloc>();

  @override
  Widget buildView(BuildContext context) {
    return const LoginScreen();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Space
                      70.h,

                      // Welcome Text
                      Center(child: WelcomeText()),
                      50.h,

                      // Login Form
                      LoginForm(
                        formKey: _loginFormKey,
                        loginController: _loginController,
                        passwordController: _passwordController,
                      ),
                      12.h,

                      // Navigate Button
                      AuthenticationNavigateButton(
                        onPressed: () => context.push(Routes.register),
                        text: "Hisobingiz yo'qmi?",
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
                  if (state.status == AuthenticationStatus.authenticated) {
                    ToastUi.showToast(message: "Hisobingizga muvoffaqiyatli kirildi!");
                    context.pushReplacement(Routes.home);
                  } else if (state.status == AuthenticationStatus.error) {
                    ToastUi.showError(message: state.errorMessage ?? "Hisobga kirib bo'lmadi");
                  }

                  if (state.status == AuthenticationStatus.loading) {
                    return SubmitButton(onPressed: null, loading: true);
                  } else {
                    return SubmitButton(
                      loading: loading,
                      onPressed: loading
                          ? null
                          : () {
                              if (_loginFormKey.currentState!.validate()) {
                                ToastUi.showToast(message: "Hisobingizga kirilmoqda...");

                                context.read<AuthenticationBloc>().login(
                                  _loginController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              } else {
                                ToastUi.showError(message: "Iltimos ma'lumotlarni kiriting");
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
