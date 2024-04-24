import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xFF173268);
const Color kScaffoldColor = Color(0xFFF0F0F0);
const Color kTextColor = Color(0xFF3E578E);
const Color kYellowColor = Color(0xFFE3B82A);
const Color kGreyColor = Color(0xFF494949);
Color kGreyShade300 = Colors.grey.shade300;

const TextStyle kQuestionTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: kTextColor,
);

const TextStyle kLoginTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: kTextColor,
);

const TextStyle kIntroModuleTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  color: kTextColor,
);

TextStyle kMainTitle = GoogleFonts.josefinSans(
  textStyle: const TextStyle(
    color: kScaffoldColor,
    fontSize: 35,
    letterSpacing: 3.0,
  ),
);

const checkedIcon = Icon(
  Icons.check_circle,
  color: kTextColor,
  size: 35,
);

const unCheckedIcon = Icon(
  Icons.radio_button_unchecked_outlined,
  color: Colors.grey,
  size: 35,
);

const TextStyle kOptionTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
  color: kTextColor,
);

const TextStyle kLabelTextStyle =
    TextStyle(color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.w600);

BoxDecoration kOptionBoxDecoration = BoxDecoration(
    border: Border.all(width: 2, color: kGreyShade300), shape: BoxShape.circle);

const kEmptyBox = SizedBox(
  width: 0.0,
  height: 0.0,
);
