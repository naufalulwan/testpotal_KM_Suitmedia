import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:question_1/components/input.dart';

import '../components/button.dart';
import '../constants/color.dart';
import '../providers/main_provider.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController palindromeController = TextEditingController();

  String alertText = '';

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    palindromeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider providerFunction = context.read<MainProvider>();
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 58.12),
                    child: CircleAvatar(
                      backgroundColor: primaryColor.shade300,
                      radius: 50.0,
                      child: const Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 35.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Input(
                    label: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 22.12,
                  ),
                  Input(
                    label: 'Palindrome',
                    controller: palindromeController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Button(
                      label: 'CHECK',
                      onPressed: () {
                        String? reverse = palindromeController.text
                            .split('')
                            .reversed
                            .join('');

                        if (palindromeController.text == reverse &&
                            palindromeController.text.isNotEmpty) {
                          alertText = 'Is Palindrome';
                        } else if (palindromeController.text.isEmpty) {
                          alertText = 'No Data';
                        } else {
                          alertText = 'Not Palindrome';
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alertDialog();
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Button(
                      label: 'NEXT',
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          providerFunction.changeDataUser(nameController.text);
                        }
                        Navigator.of(context).pushNamed('/second');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alertDialog() {
    return AlertDialog(
      title: Text('Check Result'),
      content: Text(alertText),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
