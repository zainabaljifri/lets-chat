import 'package:flutter/material.dart';
import 'package:lets_chat/screens/phoneVerify.dart';
import 'package:lets_chat/screens/signin.dart';
import 'package:lets_chat/screens/verification.dart';
import '../components/custom_button.dart';
import '../components/custom_input.dart';
import '../components/navigator.dart';
import '../controllers/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  static const String id = "Sign_up";
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  final TextEditingController _name = TextEditingController(),
      _email = TextEditingController(),
      _password = TextEditingController(),
      _confirmPassword = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool _loading = false;

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      print('valid input');
      try {
        var user = await auth.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);
        setState(() => _loading = false);
        Navigator.pushNamed(context, Verification.id);
      } catch (e) {
        setState(() => _loading = false);
        final snackBar = SnackBar(
          content: Text(e.toString()),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 70, right: 27, bottom: 60, left: 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Let’s sign you up",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                      'Please enter your information below to create an account',
                      style: TextStyle(fontSize: 18)),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInput(
                          submitted: _submitted,
                          controller: _name,
                          hint: 'Enter your full name',
                          isPassword: false,
                          validation: valName),
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
                      CustomInput(
                          submitted: _submitted,
                          controller: _confirmPassword,
                          hint: 'Confirm your password',
                          isPassword: true,
                          validation: valConfirmPass,
                          passwordToConfirm: _password.text),
                      CustomButton(text: "Sign up", onPressed: _submit),
                      const AccountNavigator(
                          question: 'Already have an account? ',
                          goToPage: 'Sign In',
                          path: SignIn.id),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
