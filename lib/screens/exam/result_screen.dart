import 'dart:convert';
import 'package:frontend/configs/app_helper.dart';
import 'package:frontend/models/exam_model.dart';
import 'package:frontend/providers/exam/exam_provider.dart';
import 'package:frontend/widget/widget_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultExamScreen extends StatefulWidget {
  static const String routeName = '/result-exam-screen';

  static Route route(List<ExamModel> questions,
      Map<int, GetPilihanGanda> answers, DateTime start, DateTime end) {
    return MaterialPageRoute(
      builder: (_) => ResultExamScreen(
        questions: questions,
        answers: answers,
        start: start,
        end: end,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final List<ExamModel> questions;
  final Map<int, GetPilihanGanda> answers;
  final DateTime start;
  final DateTime end;
  const ResultExamScreen({
    Key? key,
    required this.questions,
    required this.answers,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ResultExamScreenState createState() => _ResultExamScreenState();
}

class _ResultExamScreenState extends State<ResultExamScreen> {
  late List<ExamModel> questions;
  late Map<int, GetPilihanGanda> answers;
  late DateTime start;
  late DateTime end;

  int tkp = 0;
  int twk = 0;
  int tiu = 0;
  bool isloading = false;

  Future<void> saveResult() async {
    context
        .read(examProvider.notifier)
        .saveResult(questions[0].getPaket!.pkId!, twk, tiu, tkp, start, end)
        .then((value) {
      Navigator.pop(context);
    }).catchError((onError) {
      messageDialog(context, onError.toString());
    });
  }

  void doCount() async {
    for (var i = 0; i < questions.length; i++) {
      if (questions[i].getKategori!.ktId == 1) {
        // TWK
        if (questions[i].getKunci!.skjIdJawaban ==
            answers[i]!.sjId.toString()) {
          twk += int.parse(questions[i].getKategori!.ktNilaiBenar!);
        } else {
          twk += questions[i].getKategori!.ktNilaiSalah!;
        }
      }

      if (questions[i].getKategori!.ktId == 2) {
        // TIU
        if (questions[i].getKunci!.skjIdJawaban ==
            answers[i]!.sjId.toString()) {
          tiu += int.parse(questions[i].getKategori!.ktNilaiBenar!);
        } else {
          tiu += questions[i].getKategori!.ktNilaiSalah!;
        }
      }

      if (questions[i].getKategori!.ktId == 3) {
        // TKP

        var nilais = jsonDecode(questions[i].getKunci!.skjIdJawaban!) as List;
        for (var j = 0; j < nilais.length; j++) {
          Map<String, dynamic> data = nilais[j];
          // print("id_jawaban" + data['id_jawaban']);
          // print("id_answer" + answers[i]!.sjId.toString());
          // inspect(data['nilai_jawaban']);
          // inspect(data['id_jawaban']);

          if (data['id_jawaban'] == answers[i]!.sjId!) {
            tkp += int.parse(data['nilai_jawaban']);
          }
        }
      }
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    questions = widget.questions;
    answers = widget.answers;
    start = widget.start;
    end = widget.end;
    doCount();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar halaman dan simpan hasil?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  saveResult();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Latihan"),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            ResultWidget(value: tkp, label: "TKP"),
            ResultWidget(value: twk, label: "TWK"),
            ResultWidget(value: tiu, label: "TIU"),
            const SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final qs = questions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(
                        data: qs.sPertanyaan!,
                        style: {
                          "body": Style(
                            fontSize: const FontSize(18.0),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                        },
                      ),
                      Html(
                        data: "Pembahasan : ${qs.getKunci!.skjPembahasan!}",
                        style: {
                          "body": Style(
                            fontSize: const FontSize(12.0),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
