import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import './question.dart';
import './option.dart';

import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function callBackFunction;
  final int questionIndex;

  Quiz(
      {required this.questions,
      required this.callBackFunction,
      required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'] as String,
        ),
        ...(questions[questionIndex]['optionText'] as List<Map<String, Object>>)
            .map((option) {
          return Option(
            answerText: option['text'] as String,
            callBackFunction: () => callBackFunction(option['score']),
          );
        })
      ],
    );
  }
}
