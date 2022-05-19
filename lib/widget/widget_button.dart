import 'package:frontend/configs/app_theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String hint;
  final GestureTapCallback? onTap;

  const PrimaryButton({
    Key? key,
    required this.hint,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1, bottom: 20.0),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradientTheme,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          hint,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
