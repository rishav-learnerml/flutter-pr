// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/quiz.dart';
import 'package:flutter_quiz_app/result.dart';

// entry point
void main() => runApp(MyApp());

//blueptint for out app
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _myQuestions = const [
    {
      "questionText": "What is your favourite animal?",
      "optionText": [
        {"text": "Lion", "score": 40},
        {"text": "Raven", "score": 30},
        {"text": "Mongoose", "score": 20},
        {"text": "Snake", "score": 10}
      ]
    },
    {
      "questionText": "Which Deathly Hallow you want?",
      "optionText": [
        {"text": "The Elder wand", "score": 30},
        {"text": "The invisibility cloak", "score": 20},
        {"text": "The resurrection stone", "score": 10}
      ]
    },
    {
      "questionText": "Which character are you like?",
      "optionText": [
        {"text": "Harry Potter", "score": 50},
        {"text": "Albus Dumbledoor", "score": 100},
        {"text": "Severous Snape", "score": 60},
        {"text": "Hermione Granger", "score": 40},
        {"text": "Tom Riddle", "score": 0},
        {"text": "Ron Weasley", "score": 20},
      ]
    },
  ];

  var _questionIndex = 0;
  var _totalscore = 0;

  void _resetIndex() {
    setState(() {
      _questionIndex = 0;
      _totalscore = 0;
    });
  }

  void _answerQuestion(int score) {
    print("Welcome to Hogwartz school of witchcraft and wizawdry!!!" +
        _questionIndex.toString());

    _totalscore += score;

    setState(() {
      // if (_questionIndex < 0) {
      //   _questionIndex = 0;
      // }

      // if (_questionIndex > _myQuestions.length - 1) _questionIndex--;

      // (_questionIndex <= _myQuestions.length - 1)
      //     ? (_questionIndex == _myQuestions.length - 1)
      //         ? _questionIndex -= 2
      //         : _questionIndex++
      //     : _questionIndex--;

      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome to Hogwartz!",
          ),
        ),
        body: Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: _questionIndex < _myQuestions.length
                ? Quiz(
                    questions: _myQuestions,
                    questionIndex: _questionIndex,
                    callBackFunction: _answerQuestion,
                  )
                : Result(_totalscore, _resetIndex)),
      ),
    );
  }
}
