import 'package:flutter/material.dart';

// Get Month Name when the input starts January at 0
String getMonthName (int monthZ) {
  var month = monthZ;
  switch (month) {
    case 1: return 'มกราคม'; break;
    case 2: return 'กุมภาพันธ์'; break;
    case 3: return 'มีนาคม'; break;
    case 4: return 'เมษายน'; break;
    case 5: return 'พฤษภาคม'; break;
    case 6: return 'มิถุนายน'; break;
    case 7: return 'กรกฎาคม'; break;
    case 8: return 'สิงหาคม'; break;
    case 9: return 'กันยายน'; break;
    case 10: return 'ตุลาคม'; break;
    case 11: return 'พฤศจิกายน'; break;
    case 12: return 'ธันวาคม'; break;
    default: {
      return 'ERROR';
    }
  }
}

// when the input starts value one at January
String getMonthNameStartOne (int monthZ) {
  return getMonthName (monthZ - 1);
}

String getMonthNameShort (int monthZ) {
  var month = monthZ;
  switch (month) {
    case 1: return 'ม.ค'; break;
    case 2: return 'ก.พ'; break;
    case 3: return 'มี.ค'; break;
    case 4: return 'เม.ย'; break;
    case 5: return 'พ.ค.'; break;
    case 6: return 'มิ.ย'; break;
    case 7: return 'ก.ค.'; break;
    case 8: return 'ส.ค.'; break;
    case 9: return 'ก.ย.'; break;
    case 10: return 'ต.ค.'; break;
    case 11: return 'พ.ย.'; break;
    case 12: return 'ธ.ค.'; break;
    default: {
      return 'ERROR';
    }
  }
}

double numberToDouble (var input) {
  if (input is int) {
    return input.toDouble();
  } else {
    return input;
  }
}

int convertYearToBE (int year) {
  return year + 543;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String formatMinute (int input) {
  print(input);
  if (input > 10) {
    return input.toString();
  } else {
    return '0' + input.toString();
  }
}

String formatPrice(var input) {
  if (input is int) {
    return input.toDouble().toStringAsFixed(2);
  } else {
    return input.toStringAsFixed(2);
  }
}

String formatStar(var input) {
  if (input is int) {
    return input.toDouble().toStringAsFixed(1);
  } else {
    return input.toStringAsFixed(1);
  }
}