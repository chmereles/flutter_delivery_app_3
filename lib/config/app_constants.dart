import 'package:flutter/material.dart';

const factor = 1.36;

class AppConstants {
  static const sepLeft = 11.0 * factor;
  static const cardElevation = 5.0;
  static const defaultIconSize = 24.0;
  static const googleMapCorrectionFactor = 1.18;
  static const openStreetMapUrlTemplate =
      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const openStreetMapSubdomain = ['a', 'b', 'c'];

  static const orsBaseUrl = 'https://api.openrouteservice.org/';
  static const orsDirections = 'v2/directions/';
  static const orsApiKey =
      '5b3ce3597851110001cf62486d5cfc78392446fba599f60bfeffe0dd';
  static const orsOffsetDirection = 0.00015;
}

class AppColors {
  static const facebookColor = Color.fromRGBO(73, 95, 168, 1);
  static const googleColor = Color.fromRGBO(81, 159, 244, 1);
}
