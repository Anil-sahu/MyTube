import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  var controller;
  var pref;
  var suf;
  var keyType;
  var hint;
  var label;
  TextFields(
      {super.key,
      required this.controller,
      this.pref,
      this.suf,
      this.keyType,
      this.hint,
      this.label});

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.label.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(252, 201, 199, 199), fontSize: 20),
                )),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(boxShadow: [
            const BoxShadow(
                offset: Offset(0, 0),
                color: Color.fromARGB(0, 255, 255, 255),
                blurRadius: 2,
                spreadRadius: 0)
          ], borderRadius: BorderRadius.circular(12)),
          child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyType,
              style: const TextStyle(
                  color: Color.fromARGB(111, 248, 248, 248),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: true,
                fillColor: const Color.fromARGB(66, 250, 250, 250),
                suffixIcon: Icon(widget.suf, color: const Color.fromARGB(246, 194, 193, 193)),

                prefixIcon: Icon(
                  widget.pref,
                  color: const  Color.fromARGB(246, 194, 193, 193),
                ),
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Color.fromARGB(255, 190, 190, 190),fontSize: 16),
                // label: Text(widget.label.toString(),style: TextStyle(color: Colors.white24),)),
              )),
        ),
      ],
    );
  }
}
