import 'package:frontend/configs/config.dart';
import 'package:frontend/models/exam_model.dart';
import 'package:frontend/providers/exam/exam_provider.dart';
import 'package:frontend/providers/exam/pakage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexExamScreen extends StatefulWidget {
  static const String routeName = '/index-exam-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const IndexExamScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const IndexExamScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _IndexExamScreenState createState() => _IndexExamScreenState();
}

class _IndexExamScreenState extends State<IndexExamScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> getSoal(PaketModel paket) async {
    isLoading.value = true;
    await context
        .read(examProvider.notifier)
        .getSoal(paket.pkId!)
        .then((value) {
      isLoading.value = false;

      if (value.isNotEmpty) {
        Navigator.pushNamed(context, '/detail-exam-screen', arguments: value);
      } else {
        messageDialog(context, "Tidak ada soal di paket ini!");
      }
    }).catchError((onError) {
      isLoading.value = false;
      messageDialog(context, onError['message']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Paket"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/history-exam-screen');
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (_, value, __) {
          if (value) {
            return ListView(
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }

          return Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, watch, child) {
                    final paketData = watch(packageProvider);
                    return paketData.when(
                      data: (value) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                getSoal(value[index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: themeLightColors,
                                ),
                                child: Center(
                                  child: Text(
                                    "Paket  : ${value[index].pkNama!}",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: mTextStyle,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: value.length,
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
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/index-user-screen');
        },
        child: const Icon(Icons.person),
      ),
    );
  }
}
