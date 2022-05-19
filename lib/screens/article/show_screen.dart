// ignore_for_file: library_private_types_in_public_api

import 'package:frontend/configs/app_helper.dart';
import 'package:frontend/configs/app_theme.dart';
import 'package:frontend/models/article_model.dart';
import 'package:frontend/widget/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowArticleScreen extends StatefulWidget {
  static const String routeName = '/show-article-screen';

  static Route route(ArticleModel articleModel) {
    return MaterialPageRoute(
      builder: (_) => ShowArticleScreen(
        data: articleModel,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final ArticleModel data;
  const ShowArticleScreen({Key? key, required this.data}) : super(key: key);

  @override
  _ShowArticleScreenState createState() => _ShowArticleScreenState();
}

class _ShowArticleScreenState extends State<ShowArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detil Artikel"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.data.gambar!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: const EdgeInsets.all(40.0),
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(color: themeDarkColors.withAlpha(100)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.data.judul!,
                            maxLines: 5,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(7.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text(
                                      widget.data.createdAt!,
                                      textAlign: TextAlign.end,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.data.deskripsi!,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      PrimaryButton(
                        hint: "Sumber",
                        onTap: () async {
                          if (await canLaunchUrl(
                              Uri.parse(widget.data.sumber!))) {
                            await launchUrl(Uri.parse(widget.data.sumber!));
                          } else {
                            messageDialog(context, "Could not launch");
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
