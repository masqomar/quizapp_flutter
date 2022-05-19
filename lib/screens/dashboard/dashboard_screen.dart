import 'package:frontend/configs/app_theme.dart';
import 'package:frontend/providers/article/article_provider.dart';
import 'package:frontend/widget/widget_card_featur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const DashboardScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Latihan CPNS\u{1F4DA}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/notification-screen");
            },
            icon: const Icon(Icons.notification_add),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: size.height * 0.28,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: gradientTheme,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(
              'assets/images/banner.jpg',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Fitur",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CardFitur(
                  hintText: "Latihan",
                  icon: "exam.svg",
                  onTap: () {
                    Navigator.pushNamed(context, '/index-exam-screen');
                  }),
              CardFitur(
                  hintText: "Artikel",
                  icon: "article.svg",
                  onTap: () {
                    Navigator.pushNamed(context, '/index-article-screen');
                  }),
              CardFitur(
                  hintText: "Riwayat",
                  icon: "forum.svg",
                  onTap: () {
                    Navigator.pushNamed(context, '/history-exam-screen');
                  }),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 30, 5, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Artikel Baru",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "lihat semua",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, watch, child) {
              final articles = watch(articleProvider);
              return articles.when(
                data: (value) {
                  return ListView.builder(
                    itemCount: value.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        height: 190,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              height: 104,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox.fromSize(
                                  child: Image.network("${value[index].gambar}",
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Text(
                                    value[index].deskripsi!,
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${value[index].judul}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/show-article-screen",
                                              arguments: value[index]);
                                        },
                                        child: const Text(
                                          "read more",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
        ],
      ),
    );
  }
}
