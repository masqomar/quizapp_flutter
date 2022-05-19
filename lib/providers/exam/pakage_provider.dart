import 'package:frontend/models/exam_model.dart';
import 'package:frontend/providers/global_provider.dart';
import 'package:frontend/repositories/exam_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final packageProvider =
    StateNotifierProvider<PackageProvider, AsyncValue<List<PaketModel>>>((ref) {
  final packageData = ref.read(examRepository);

  return PackageProvider(packageData);
});

class PackageProvider extends StateNotifier<AsyncValue<List<PaketModel>>> {
  PackageProvider(this._examRepository, [AsyncValue<List<PaketModel>>? state])
      : super(const AsyncValue.data([])) {
    getPaket();
  }

  final ExamRepository? _examRepository;

  Future<void> getPaket() async {
    try {
      state = const AsyncValue.loading();

      final data = await _examRepository!.getPaket();

      if (mounted) {
        state = AsyncValue.data([...data]);
      }
    } catch (e) {
      state = AsyncError(e.toString());
    }
  }
}
