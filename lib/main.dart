import 'package:flutter/material.dart';

import 'app.dart';
import 'config/di/injection.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();

  runApp(const App());
}
