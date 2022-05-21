import 'package:flutter/material.dart';

InputDecoration editTextDecoration({hint}){
  return InputDecoration(
    hintText: hint,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.white,
          width: 2.0,
        ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: (Colors.purple[800])!,
        width: 2.0,
      ),
    ),
  );
}

InputDecoration saloonEditTextDecoration({hint}){
  return InputDecoration(
    hintText: hint,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: (Colors.blue[800])!,
        width: 2.0,
      ),
    ),
  );
}

InputDecoration saloonUpdateEditTextDecoration({hint}){
  return InputDecoration(
    hintText: hint,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: (Colors.blue[800])!,
        width: 2.0,
      ),
    ),
  );
}