import 'package:flutter/material.dart';
import 'screens/signup.dart';
import 'screens/signin.dart';
import 'theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/verification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LetsChat());
}

class LetsChat extends StatelessWidget {
  const LetsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeDark,
      routes: <String, WidgetBuilder>{
        '/': (_) => const SignIn(), // Login Page
        // '/profile': (_) => const Profile(), // Home Page
        '/signup': (_) => const SignUp(), // The SignUp page
        '/verify': (_) => const Verification(), // تصل ولا ماتصل
      },
    );
  }
}
