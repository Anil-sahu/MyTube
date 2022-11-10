import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFields extends StatefulWidget {
  var controller;
  var pref;
  var suf;
  var keyType;
  var hint;
  var label;
   TextFields({super.key,required this.controller,this.pref,this.suf,this.keyType,this.hint,this.label});

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child:  TextField(
        controller: widget.controller,
        keyboardType: widget.keyType,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: true,
            fillColor: Color.fromARGB(255, 252, 252, 252),suffixIcon: Icon(widget.suf),
            prefixIcon: Icon(widget.pref),
            hintText: widget.hint,
            label: Text(widget.label.toString())),
      ),
    );
  }
}
