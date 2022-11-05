import 'package:flutter/material.dart';
import 'screens/signup.dart';
import 'screens/signin.dart';
import 'constants.dart';

void main() {
  runApp(const LetsChat());
}

class LetsChat extends StatelessWidget {
  const LetsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const SignIn(),
      theme: ThemeData(
          fontFamily: "Poppins",
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kBGColor,
          appBarTheme: const AppBarTheme(
              backgroundColor: kBGColor,
              elevation: 0,
              toolbarHeight: 120,
              centerTitle: false)),
      routes: <String, WidgetBuilder>{
        '/': (_) => const SignIn(), // Login Page
        // '/profile': (_) => const Profile(), // Home Page
        '/signup': (_) => const SignUp(), // The SignUp page
      },
    );
  }
}
