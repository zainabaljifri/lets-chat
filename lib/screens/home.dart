import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_chat/constants.dart';

class Home extends StatefulWidget {
  static const String id = "Home_screen";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void signout() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [IconButton(onPressed: signout, icon: Icon(Icons.close))],
        // backgroundColor: Colors.red,
      ),
    );
  }
}
