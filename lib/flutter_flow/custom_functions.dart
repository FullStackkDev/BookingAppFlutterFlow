import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

LatLng? getLatLong(
  double? latitude,
  double? longitude,
) {
  return LatLng(latitude!, longitude!);
}

List<LatLng>? getListLatLong(
  List<double>? latitude,
  List<double>? longitude,
) {
  List<LatLng> latLngList = [];

  for (int i = 0; i < latitude!.length && i < longitude!.length; i++) {
    latLngList.add(LatLng(latitude[i], longitude[i]));
  }

  return latLngList;
}
