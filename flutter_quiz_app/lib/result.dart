import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetAction;

  Result(this.totalScore, this.resetAction);

  String get showResult {
    var houseName = '';
    if (totalScore >= 120) {
      houseName = "Your have been chosen for Glyffendoor";
    } else if (totalScore >= 70) {
      houseName = "Your have been chosen for Ravenclaw";
    } else if (totalScore >= 60) {
      houseName = "Your have been chosen for Hufflepuff";
    } else if (totalScore >= 50) {
      houseName = "Your have been chosen for Slytherin";
    } else {
      houseName = "Sorry!! You're a muggle!!";
    }
    return houseName;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "${totalScore > 40 ? 'Welcome to Hogwartz school of witchcraft and wizadry!!\n' : ''} ${showResult}!!",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 142, 37, 5)),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 86, 28, 233))),
              onPressed: resetAction,
              child: Text("Restart Sorting!"))
        ],
      ),
    );
  }
}
