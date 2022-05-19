import 'package:frontend/configs/app_style_font.dart';
import 'package:frontend/models/exam_model.dart';
import 'package:frontend/providers/exam/exam_provider.dart';
import 'package:frontend/widget/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailExamScreen extends StatefulWidget {
  static const String routeName = '/detail-exam-screen';

  static Route route(List<ExamModel> data) {
    return MaterialPageRoute(
      builder: (_) => DetailExamScreen(
        data: data,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final List<ExamModel> data;

  const DetailExamScreen({Key? key, required this.data}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailExamScreenState createState() => _DetailExamScreenState();
}

class _DetailExamScreenState extends State<DetailExamScreen> {
  late DateTime start;
  late DateTime end;
  late List<ExamModel> dataExam;
  GetPilihanGanda answer = GetPilihanGanda();
  final Map<int, GetPilihanGanda> _answers = {};

  Future<bool> _willPopCallback() async {
    context.read(numberQuestionProvider).state = 0;
    return true;
  }

  @override
  void initState() {
    super.initState();
    start = DateTime.now();
    dataExam = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latihan Soal "),
      ),
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: Consumer(
          builder: (_, watch, __) {
            final numberQuestionState = watch(numberQuestionProvider).state;

            return ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dataExam.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read(numberQuestionProvider).state = index;
                        },
                        child: Card(
                          color: dataExam[index].isSelected == true
                              ? Colors.green
                              : numberQuestionState == index
                                  ? Colors.amber
                                  : Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "${index + 1} ",
                              style: mTextStyle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Html(
                  data: dataExam[numberQuestionState].sPertanyaan!,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.redAccent),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      dataExam[numberQuestionState].getKategori!.ktNama!,
                      style: mTextStyle,
                    ),
                  ),
                ),
                ...dataExam[numberQuestionState]
                    .getPilihanGanda!
                    .map((pilihanGanda) {
                  return RadioListTile<GetPilihanGanda>(
                      title: Html(data: pilihanGanda.sjJawaban!),
                      value: pilihanGanda,
                      groupValue: _answers[numberQuestionState],
                      onChanged: (value) {
                        setState(() {
                          dataExam[numberQuestionState].selected(true);
                          _answers[numberQuestionState] = value!;
                        });
                      });
                }).toList(),
                _answers.length == dataExam.length
                    ? Container(
                        margin: const EdgeInsets.all(5),
                        child: PrimaryButton(
                          hint: "Lihat Hasil",
                          onTap: () {
                            context.read(numberQuestionProvider).state = 0;
                            end = DateTime.now();
                            List args = [dataExam, _answers, start, end];
                            Navigator.pushReplacementNamed(
                              context,
                              '/result-exam-screen',
                              arguments: args,
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
