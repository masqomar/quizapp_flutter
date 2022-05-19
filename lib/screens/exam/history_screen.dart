import 'package:frontend/configs/app_helper.dart';
import 'package:frontend/models/history_model.dart';
import 'package:frontend/providers/exam/exam_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryExamScreen extends StatefulWidget {
  static const String routeName = '/history-exam-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HistoryExamScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HistoryExamScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HistoryExamScreenState createState() => _HistoryExamScreenState();
}

class _HistoryExamScreenState extends State<HistoryExamScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  List<HistoryModel> history = [];
  Future<void> getHistory() async {
    await context.read(examProvider.notifier).getHistory().then((value) {
      history = value;
    }).catchError((onError) {
      history = [];
      messageDialog(context, onError['message']);
    });
    isLoading.value = false;
  }

  formatTime(dt) {
    return DateFormat.jms().format(DateTime.parse(dt.toString()));
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Latihan"),
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

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue[900],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TIU: ${history[index].nilaiTiu}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "TKP: ${history[index].nilaiTkp}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "TWK: ${history[index].nilaiTwk}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Pengerjaan: ${formatTime(history[index].startWaktuMengerjakan)} - ${formatTime(history[index].endWaktuMengerjakan)}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
