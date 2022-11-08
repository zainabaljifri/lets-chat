import 'package:flutter/material.dart';
import 'screens/signup.dart';
import 'screens/signin.dart';
import 'theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/verification.dart';
import 'screens/phoneverify.dart';

Future<void> main() async {
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
      initialRoute: SignIn.id,
      routes: {
       SignIn.id: (context) => const SignIn(), // Login Page
        SignUp.id: (context) => const SignUp(), // The SignUp page
        Verification.id: (context) => const Verification(),
        MyVerify.id: (context) => const MyVerify(), // تصل ولا ماتصل
      },
    );
  }
}
