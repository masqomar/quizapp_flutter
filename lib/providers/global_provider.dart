import 'package:frontend/repositories/article_repository.dart';
import 'package:frontend/repositories/exam_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/repositories/auth_repository.dart';

final authRepository = Provider((_) => AuthRepository());
final articleRepository = Provider((_) => ArticleRepository());
final examRepository = Provider((_) => ExamRepository());
final globalLoading = StateProvider.autoDispose<bool>((ref) => false);
