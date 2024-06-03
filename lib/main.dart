import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semaphore_app/src/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const SemaphoreApp());
}

class SemaphoreApp extends StatelessWidget {
  const SemaphoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const SafeArea(child: HomeScreen()),
    );
  }
}
