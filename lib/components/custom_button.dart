import 'package:flutter/material.dart';
import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        ),
        onPressed: () {
          onPressed();
        },
        // child: Container(
        //   padding: const EdgeInsets.only(
        //     top: 20,
        //     bottom: 20,
        //   ),
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //     borderRadius: kBorderRadius,
        //     color: kPrimaryColor,
        //   ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20, color: kBGColor, fontWeight: FontWeight.w600),
        ),
        // ),
      ),
    );
  }
}
