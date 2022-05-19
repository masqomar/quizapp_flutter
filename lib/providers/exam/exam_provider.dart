import 'package:frontend/models/exam_model.dart';
import 'package:frontend/models/history_model.dart';
import 'package:frontend/providers/global_provider.dart';
import 'package:frontend/repositories/exam_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final examProvider =
    StateNotifierProvider<ExamProvider, List<ExamModel>>((ref) {
  final examData = ref.read(examRepository);

  return ExamProvider(examData);
});

class ExamProvider extends StateNotifier<List<ExamModel>> {
  ExamProvider(this._examRepository) : super([]);

  final ExamRepository? _examRepository;

  Future<List<ExamModel>> getSoal(int idPaket) async {
    try {
      final data = await _examRepository!.getSoal(idPaket);

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<HistoryModel>> getHistory() async {
    try {
      final data = await _examRepository!.getHistory();

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> saveResult(int idPaket, int twk, int tiu,
      int tkp, DateTime start, DateTime end) async {
    try {
      final data = await _examRepository!.saveResult(
        idPaket,
        twk,
        tiu,
        tkp,
        start,
        end,
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

final numberQuestionProvider = StateProvider<int>((ref) {
  return 0;
});
