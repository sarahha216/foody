import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foody/pages/sign_in_page.dart';

import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foody',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashPage(),
      routes: {
        '/signIn': (context) => const SignInPage(),
      },
    );
  }
}
