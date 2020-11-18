import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Ash',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
        TextSpan(
            text: 'Quizzer',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.redAccent)),
      ],
    ),
  );
}

Widget blueButton(BuildContext context, String label) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 19),
    alignment: Alignment.center,
    width:MediaQuery.of(context).size.width - 50,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
