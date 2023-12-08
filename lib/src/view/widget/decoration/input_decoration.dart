import 'package:flutter/material.dart';

// This function returns an `InputDecoration` object for styling a text field input.
// It takes an optional `hint` parameter to provide a hint text for the input field.
InputDecoration textFieldInputDecoration({String hint = ''}) => InputDecoration(
      contentPadding: const EdgeInsets.only(
        left: 10,
        bottom: 10,
        top: 10,
        right: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      hintText: hint, // Set the hint text for the input field.
    );
