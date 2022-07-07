import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({Key? key, required this.label, required this.controller})
      : super(key: key);

  String? label;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 39.88,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Colors.black38, fontWeight: FontWeight.w400),
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }
}
