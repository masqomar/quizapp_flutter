import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final TextInputType txtInputType;
  final IconData icon;
  final TextEditingController? controller;
  final bool? obsText;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;

  const PrimaryTextField({
    Key? key,
    required this.hintText,
    required this.txtInputType,
    required this.icon,
    this.controller,
    this.onTap,
    this.obsText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        obscureText: obsText!,
        keyboardType: txtInputType,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFFe7edeb),
          hintText: hintText,
          suffixIcon: Icon(icon, color: Colors.grey[400]),
        ),
      ),
    );
  }
}
