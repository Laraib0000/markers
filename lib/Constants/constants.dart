import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trigon_application/Constants/colors.dart';

const primaryColor = "#2e2e2e";
const greyColor = "#404040";
const lightBlueColor = "#3e586a";
const backgroundColor = "#d2d6df";
const backgroundGreyColor = "#f8f7f7";
const popUpBackgroundColor = "#cbcbcb";
const appGreenColor = "#016347";
const rightMsgBackcolor = "#f5f6fa";
const leftMsgBackColor = "#dddddd";

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class Constants {
  Constants._();
  static const double padding = 15;
  static const double avatarRadius = 44;
}

const avatarImage =
    "https://cdn5.vectorstock.com/i/thumb-large/85/94/person-gray-photo-placeholder-man-silhouette-sign-vector-23838594.jpg";
const baseUrl = "https://api.klosrr.com/api/v1/";

int totalFriends = 0;
int totalRequest = 0;

final boldText =
    TextStyle(color: blackC, fontSize: 24, fontWeight: FontWeight.bold);
final normalText = TextStyle(color: lightBC, fontSize: 20);
final smallText = TextStyle(color: lightBC, fontSize: 16);
final divider = Divider(
  endIndent: 20,
  indent: 20,
  color: dividerC,
);
