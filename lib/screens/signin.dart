import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_input.dart';
import '../components/navigator.dart';
import '../controllers/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  final TextEditingController _email = TextEditingController(),
      _password = TextEditingController();
  final auth = FirebaseAuth.instance;

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      print('valid input');
      try{
        var user = await auth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
       Navigator.of(context).pushReplacementNamed('/verify');
        print('signed in successfully');
      }catch(e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 70, right: 27, bottom: 60, left: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Let’s sign you in",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                    'Welcome back\nyou’ve been missed!',
                    style: TextStyle(fontSize: 18)),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInput(
                        submitted: _submitted,
                        controller: _email,
                        hint: 'Enter your email address',
                        isPassword: false,
                        validation: valEmail),
                    CustomInput(
                        submitted: _submitted,
                        controller: _password,
                        hint: 'Enter your password',
                        isPassword: true,
                        validation: valPass),
                    CustomButton(text: "Sign In", onPressed: _submit),
                    const AccountNavigator(question:'Don\'nt have an account? ',goToPage:'Sign Up', path:'/signup'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
