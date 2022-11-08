import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_chat/screens/home.dart';
import 'dart:async';
import 'package:lets_chat/components/custom_button.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool isEmailVerify = false;
  Timer? timer;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerify) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => chekEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future chekEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerify) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerify
        ? Home()
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('omkk سوي تحقق'),
                CustomButton(
                    text: 'Resend Email Verification',
                    onPressed: () {
                      sendVerificationEmail();
                    }),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                    text: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                      _auth.signOut();
                    })
              ],
            ),
          );
  }
}
