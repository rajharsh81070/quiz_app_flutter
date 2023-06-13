import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  int currentScreen = 0;

  void onStartQuizPress() {
    setState(() {
      currentScreen = 1;
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        currentScreen = 2;
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      currentScreen = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget renderChild() {
      if (currentScreen == 0) {
        return StartScreen(
          key: const Key('start_screen'),
          onPress: onStartQuizPress,
        );
      } else if (currentScreen == 1) {
        return QuestionsScreen(
          onSelectAnswer: chooseAnswer,
        );
      } else {
        return ResultsScreen(
          choosenAnswers: selectedAnswers,
          onRestart: restartQuiz,
        );
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 149, 123, 123),
                Color.fromARGB(255, 52, 50, 50)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: renderChild(),
        ),
      ),
    );
  }
}
