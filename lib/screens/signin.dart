import 'package:flutter/material.dart';
import 'package:lets_chat/screens/signup.dart';
import '../components/custom_button.dart';
import '../components/custom_input.dart';
import '../components/navigator.dart';
import '../controllers/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lets_chat/screens/verification.dart';

class SignIn extends StatefulWidget {
  static const String id = "Sign_in";
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  final TextEditingController _email = TextEditingController(),
      _password = TextEditingController(),
      _phone = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool _loading = false;

  void phoneAuth() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+966${_phone.text}".trim(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).pushReplacementNamed('/phoneverify');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      print('valid input');
      phoneAuth();
      try {
        var user = await auth.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
        setState(() => _loading = false);
        Navigator.pushNamed(context, Verification.id);
        print('signed in successfully');
      } catch (e) {
        setState(() => _loading = false);
        print(e);
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
                const Text("Let’s sign you in",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text('Welcome back\nyou’ve been missed!',
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
                      const Text('or'),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: TextEditingController(text: '+966'),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Text(
                              "|",
                              style:
                                  TextStyle(fontSize: 33, color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextField(
                              controller: _phone,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone",
                              ),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomButton(text: "Sign In", onPressed: _submit),
                      const AccountNavigator(
                          question: 'Don\'nt have an account? ',
                          goToPage: 'Sign Up',
                          path: SignUp.id),
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
