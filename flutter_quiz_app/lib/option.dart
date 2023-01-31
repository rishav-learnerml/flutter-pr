// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  // final String houseName;
  // final Color colorName;
  final VoidCallback callBackFunction;

  final String answerText;

  Option({required this.answerText, required this.callBackFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: () {
          // _answerQuestion();
          callBackFunction();
          // print("You are chosen for ${houseName}!!");
        },
        child: Text(
          answerText,
        ),
      ),
    );
  }
}
