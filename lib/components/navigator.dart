import 'package:flutter/material.dart';
import '../constants.dart';

class AccountNavigator extends StatelessWidget {
  final String question;
  final String goToPage;
  final String path;
  const AccountNavigator(
      {Key? key,
      required this.question,
      required this.goToPage,
      required this.path
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context,path);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question,
              style: const TextStyle(fontSize: 16, color: kFGColor)),
          Text(goToPage, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
