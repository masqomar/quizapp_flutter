import 'package:frontend/repositories/exam_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/repositories/auth_repository.dart';

final authRepository = Provider((_) => AuthRepository());
final examRepository = Provider((_) => ExamRepository());
final globalLoading = StateProvider.autoDispose<bool>((ref) => false);
