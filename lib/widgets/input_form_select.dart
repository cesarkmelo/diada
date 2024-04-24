import 'dart:html';

import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFormSelect extends StatelessWidget {
  final String label;
  final List<String> list;
  final String selected;
  final FunctionStringCallback? onChanged;

  InputFormSelect(
      {required this.label,
      required this.list,
      required this.onChanged,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    String dropdownValue = selected;
    return DropdownButtonFormField(
      onChanged: (change) {},
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      style: GoogleFonts.openSansCondensed(
        textStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
      dropdownColor: kGreyColor,
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
    );
  }
}
