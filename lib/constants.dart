import 'package:flutter/material.dart';

const kPrimaryColor = Colors.white;
const kFGColor = Color(0xFF8F8F9E);
const kBGColor = Color(0xFF191720);
const kBGInput = Color(0xFF1E1C24);

final kBorderRadius = BorderRadius.circular(15.0);

final kEnabledBorder = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: const BorderSide(color: kFGColor),
);

final kFocusedBorder = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: const BorderSide(color: Colors.grey),
);

final kErrorBorder = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: const BorderSide(color: Colors.redAccent),
);
