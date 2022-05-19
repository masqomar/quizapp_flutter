import 'package:frontend/configs/app_style_font.dart';
import 'package:frontend/configs/app_theme.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: themeDarkColors,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          label,
          style: mTextStyle,
        ),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "$value",
            style: mTextStyle,
          ),
        ),
      ),
    );
  }
}
