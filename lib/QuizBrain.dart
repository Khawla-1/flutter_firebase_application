import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Test/flutter_firebase_application/lib/Question.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionScreen extends StatelessWidget{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : StreamBuilder(
          stream: _firestore.collection('Question').snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData) return ErrorWidget('error');
            return PageView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                final document = snapshot.data.documents[index];
                var _question = new Map();
               return
                _question ['question'] = document['question'];
                _question ['answer'] = document['answer'];
               
              },
            );
          }

    )

    );
  }
}

class QuizBrain {
  int _questionNumber = 0;

  var _questionBank = new Map();
  void getNextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }
  String getQuestion() {
    return _questionBank[_questionNumber].question;
  }
  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].answer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1)
      return true;
    else
      return false;
  }

  void reset() {
    _questionNumber = 0;
  }
}
