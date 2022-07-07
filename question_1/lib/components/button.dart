import 'package:flutter/material.dart';

import '../constants/color.dart';

class Button extends StatelessWidget {
  Button({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  String? label;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 41,
      child: MaterialButton(
        color: primaryColor.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        onPressed: onPressed,
        child: Text(
          label!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
