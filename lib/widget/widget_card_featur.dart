import 'package:frontend/configs/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardFitur extends StatelessWidget {
  final String hintText;
  final String icon;
  final GestureTapCallback onTap;

  const CardFitur({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: 5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: themeLightColors,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/$icon",
                width: 70,
                height: 70,
              ),
              Text(
                hintText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
