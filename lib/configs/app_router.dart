import 'package:frontend/main.dart';
import 'package:frontend/models/exam_model.dart';
import 'package:frontend/screens/exam/exam_screen.dart';
import 'package:frontend/screens/exam/history_screen.dart';
import 'package:frontend/screens/exam/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/user/index.dart';
import '../screens/screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return SplashScreen.route();

      case '/login-screen':
        return LoginScreen.route();

      case '/register-screen':
        return RegisterScreen.route();

      case '/index-exam-screen':
        return IndexExamScreen.route();

      case '/detail-exam-screen':
        final List<ExamModel> examModel = settings.arguments as List<ExamModel>;
        return DetailExamScreen.route(examModel);

      case '/result-exam-screen':
        List args = settings.arguments as List;

        final List<ExamModel> questions = args[0];
        final Map<int, GetPilihanGanda> answers = args[1];
        final DateTime start = args[2];
        final DateTime end = args[3];

        return ResultExamScreen.route(questions, answers, start, end);

      case '/history-exam-screen':
        return HistoryExamScreen.route();

      case '/index-user-screen':
        return IndexUserScreen.route();

      case '/edit-user-screen':
        return EditUserScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const ErrorScreen(),
    );
  }
}
