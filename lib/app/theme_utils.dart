import 'package:flutter/material.dart';

const lightPrimaryColor = Color(0xFF0A8791);
const lightAccentColor = Color(0xFFFBA83C);

const darkPrimaryColor = Color.fromRGBO(29, 191, 115, 1);
const darkAccentColor = Colors.blue;

const greyColor = Color(0xFFC2C2CB);
const blackColor = Color(0xFF0E122B);

// ThemeData lightTheme = ThemeData.light().copyWith(
ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',
  // brightness: Brightness.light,
  // primaryColor: lightPrimaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.light,
    primary: lightPrimaryColor,
    secondary: lightAccentColor,
  ),
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
  //
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: lightPrimaryColor,
      side: const BorderSide(color: lightPrimaryColor, width: 1.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),
  ),

  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      primary: lightPrimaryColor,
    ),
  ),

  //
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.black,
    ),
  ),

  //
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  // iconTheme: IconThemeData(color: Colors.red),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Poppins',

  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: darkAccentColor,
    brightness: Brightness.dark,
    primary: darkPrimaryColor,
  ),

  //
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: darkPrimaryColor,
      side: const BorderSide(color: darkPrimaryColor, width: 1.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),
  ),

  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      primary: darkPrimaryColor,
    ),
  ),

  //
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
    ),
  ),

  //
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);
