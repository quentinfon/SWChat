import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  labelStyle: TextStyle(
      fontFamily: 'NunitoSans'
  ),
  hintStyle: TextStyle(
      fontFamily: 'NunitoSans'
  ),
  errorStyle: TextStyle(
      fontFamily: 'NunitoSans'
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey, width: 2)
  ),
  focusColor: Colors.black,
  hoverColor: Colors.black,
);

Color getColor(String stringCouleur){

  if(stringCouleur == "rouge") return Colors.red;
  if(stringCouleur == "bleu") return Colors.blue;
  if(stringCouleur == "vert") return Colors.green;
  if(stringCouleur == "bleufonce") return Colors.indigo[900];
  if(stringCouleur == "violet") return Colors.purple;
  if(stringCouleur == "noir") return Colors.black;

  return Colors.red;
}