import 'package:flutter/material.dart';

class Stextfield extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  Widget? icon;
  bool isPassword;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  bool check;
  Stextfield(
      {this.hintText,
      this.controller,
      this.validate,
      this.isPassword = false,
      this.check = false,
      this.focusNode,
      this.inputAction,
      this.icon});

  @override
  State<Stextfield> createState() => _StextfieldState();
}

class _StextfieldState extends State<Stextfield> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: widget.controller,
        obscureText: widget.isPassword == false ? false : widget.isPassword,
        validator: widget.validate,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText ?? 'hint Text...',
            suffixIcon: widget.icon,
            contentPadding: const EdgeInsets.all(10)),
      ),
    );
  }
}
