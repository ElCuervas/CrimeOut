import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/presentation/screens/register_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CrimeOutApp(),
    ),
  );
}

class CrimeOutApp extends StatelessWidget {
  const CrimeOutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrimeOut',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const RegisterScreen(),
    );
  }
}