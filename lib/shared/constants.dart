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
      borderSide: BorderSide(color: Colors.white, width: 2)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black45, width: 2)
  ),
  focusColor: Colors.black,
  hoverColor: Colors.black,
);