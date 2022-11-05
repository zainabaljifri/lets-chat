import 'package:flutter/material.dart';
import '../constants.dart';

class CustomInput extends StatefulWidget {
  final bool submitted;
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final Function validation;
  final String? passwordToConfirm;
  const CustomInput(
      {Key? key,
      required this.submitted,
      required this.controller,
      required this.hint,
      required this.isPassword,
      required this.validation,
      this.passwordToConfirm})
      : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _passwordHidden = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: TextFormField(
        obscureText: widget.isPassword ? _passwordHidden : false,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.hint,
          labelStyle: const TextStyle(fontSize: 18, color:kFGColor),
          suffixIcon: widget.isPassword?
          GestureDetector(
            onTap: () {
              setState(() {_passwordHidden = !_passwordHidden;});
              },
            child: Icon(_passwordHidden? Icons.visibility : Icons.visibility_off,color:kFGColor),
          ): null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          filled: true,
          fillColor: kBGInput,
          focusedBorder: kFocusedBorder,
          enabledBorder: kEnabledBorder,
          errorBorder: kErrorBorder,
          focusedErrorBorder: kErrorBorder,
          errorStyle: const TextStyle(height: 0.4),
        ),
        autovalidateMode: widget.submitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        validator: (text) {
          return widget.passwordToConfirm == null
              ? widget.validation(text.toString())
              : widget.validation(widget.passwordToConfirm, text.toString());
        },
      ),
    );
  }
}
