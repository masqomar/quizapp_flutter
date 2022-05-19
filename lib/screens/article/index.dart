import 'package:frontend/configs/app_theme.dart';
import 'package:frontend/providers/article/article_provider.dart';
import 'package:frontend/providers/global_provider.dart';
import 'package:frontend/widget/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class IndexArticleScreen extends StatefulWidget {
  static const String routeName = '/index-article-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const IndexArticleScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const IndexArticleScreen({Key? key}) : super(key: key);

  @override
  _IndexArticleScreenState createState() => _IndexArticleScreenState();
}

class _IndexArticleScreenState extends State<IndexArticleScreen> {
  ScrollController controller = ScrollController();
  late ValueNotifier<bool> isloading;

  formatDate(dt) {
    return DateFormat.yMEd().format(DateTime.parse(dt.toString()));
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artikel CPNS"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.refresh(articleProvider);
        },
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final articles = watch(articleProvider);

                  return articles.when(
                    data: (value) {
                      return ListView.builder(
                        controller: controller,
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/show-article-screen",
                                  arguments: value[index]);
                            },
                            child: Card(
                              elevation: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: themeDarkColors),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            width: 1.0, color: Colors.white24),
                                      ),
                                    ),
                                    child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            NetworkImage(value[index].gambar!)),
                                  ),
                                  title: Text(
                                    "${value[index].judul}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.date_range,
                                          color: Colors.yellowAccent),
                                      Text(
                                        "${formatDate(value[index].createdAt)}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  trailing: const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.white,
                                      size: 30.0),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) {
                      return const Center(
                        child: Text(
                          "terjadi kesalahan",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ProviderListener<StateController<bool>>(
              onChange: (context, loading) async {
                if (loading.state) {
                  await LoadingWidget.showDialogLoading(context);
                } else {
                  Navigator.pop(context);
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              provider: globalLoading,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollListener() async {
    if (controller.position.extentAfter == 0) {
      context.read(globalLoading).state = true;
      await context.read(articleProvider.notifier).nextPage();
      context.read(globalLoading).state = false;
    }
  }
}
