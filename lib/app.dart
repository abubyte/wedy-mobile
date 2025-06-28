import 'package:flutter/material.dart';
import 'package:wedy/config/routes/app_router.dart';
import 'package:wedy/core/utils/themes/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Wedy",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
    );
  }
}
