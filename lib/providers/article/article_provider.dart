import 'package:frontend/models/article_model.dart';
import 'package:frontend/providers/global_provider.dart';
import 'package:frontend/repositories/article_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleProvider =
    StateNotifierProvider<ArticleProvider, AsyncValue<List<ArticleModel>>>(
        (ref) {
  final articleData = ref.read(articleRepository);

  return ArticleProvider(articleData);
});

class ArticleProvider extends StateNotifier<AsyncValue<List<ArticleModel>>> {
  ArticleProvider(this._articleRepository,
      [AsyncValue<List<ArticleModel>>? state])
      : super(const AsyncValue.data([])) {
    getArticle();
  }

  final ArticleRepository? _articleRepository;

  List<ArticleModel> datas = [];
  int initPage = 1;

  Future<void> getArticle() async {
    try {
      datas = [];
      initPage = 1;
      state = const AsyncValue.loading();

      final data = await _articleRepository!.getArticle(initPage);

      if (mounted) {
        datas = data;
        state = AsyncValue.data([...data]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }

  Future<void> nextPage() async {
    try {
      initPage += 1;
      List<ArticleModel> data = await _articleRepository!.getArticle(initPage);

      datas.addAll(data);

      if (mounted) {
        state = AsyncValue.data([...datas]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
