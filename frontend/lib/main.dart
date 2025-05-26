import 'package:flutter/material.dart';
import 'package:frontend/screens/onboarding_screen.dart';
import 'package:frontend/screens/login_screen.dart';

void main() {
  runApp(const CrimeOutApp());
}

class CrimeOutApp extends StatelessWidget {
  const CrimeOutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrimeOut',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      initialRoute: OnboardingScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
      },
    );
  }
}