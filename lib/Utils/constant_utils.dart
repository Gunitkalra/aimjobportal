import 'dart:math';
import 'dart:convert';

import 'package:aimjobs/Utils/shared_prehelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
// import 'package:paintlib/Utils/shared_prehelper.dart';


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is a safe chunk size
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


String generateOrderUniqueIdentifier(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  // Generate a random string of the specified length
  String randomString = String.fromCharCodes(
      Iterable.generate(
          length,
              (_) => characters.codeUnitAt(random.nextInt(characters.length))
      )
  );

  return randomString;
}


void showToastSuccess(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
//
// void showToastSuccess(String message) {
//
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.CENTER,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.green,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }


void showToastFail(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


// void showToastFail(String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.TOP,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.red,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }

void showToastexit(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.lightBlueAccent,
    textColor: Colors.black,
    fontSize: 16.0,
  );
}
void showToastFaillong(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 10,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,

  );
}





void showCustomToast(BuildContext context, String message, {int duration = 10}) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0,
      left: MediaQuery.of(context).size.width * 0.1, // Adjust for center alignment
      width: MediaQuery.of(context).size.width * 0.8, // Set width for multiline
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            textAlign: TextAlign.center, // Align text to the center
            maxLines: 5, // Limit to 3 lines
            softWrap: true, // Ensure text wraps properly
            overflow: TextOverflow.ellipsis, // Add ellipsis if text exceeds
          ),
        ),
      ),
    ),
  );

  // Insert the overlay
  Overlay.of(context)?.insert(overlayEntry);

  // Remove the overlay after the specified duration
  Future.delayed(Duration(seconds: duration), () {
    overlayEntry.remove();
  });
}



String formatDateonly11(String dateString) {
  if (dateString.isEmpty) {
    return ""; // Return empty if input is empty
  }
  try {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  } catch (e) {
    return ""; // Return empty if parsing fails
  }
}


Future<String> getMarketdataToken() async {
  String token= await SharedPrefHelper().get("marketdatatoken");
  return token;
}


Future<String> getUserToken() async {
  String token= await SharedPrefHelper().get("token");
  return token;
}


String formatDatewithtime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString).toLocal(); // Convert to local time if needed
  return DateFormat('d MMM yyyy h:mm a').format(dateTime);
}

String formatDateonly(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  // Use DateFormat to format the date
  return DateFormat('dd MMM yyyy').format(dateTime);

}

String formatDateOnlywithrenewaldate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString).add(Duration(days: 365)); // Add 1 year
  return DateFormat('dd MMM yyyy').format(dateTime);
}
String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  // Use DateFormat to format the date
  return DateFormat('dd ').format(dateTime);

}

String formatMonth(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  // Use DateFormat to format the date
  return DateFormat('MMMM ').format(dateTime);

}
String formatYear(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  // Use DateFormat to format the date
  return DateFormat('yyyy').format(dateTime);

}
String formatDatewithoutyr(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MMM').format(dateTime);
}

String formatOnlyTime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString).toLocal(); // Convert to local time if needed
  return DateFormat('h:mm a').format(dateTime);
}



String removeCountryCode(String phoneNumber) {
  return phoneNumber.replaceAll(RegExp(r'^\+91\s*'), '');
}


String formatDateonly1(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd-MM-yyyy').format(dateTime);
}
String formatDateonly3(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd/MM/yyyy').format(dateTime);
}


String formatDateonly2(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MM yyyy').format(dateTime);
}


String convertToIsoWithFixedTime(String dateString) {
  // Define the input format
  final inputFormat = DateFormat('dd MMM yyyy');

  // Parse the input string to DateTime
  final date = inputFormat.parse(dateString);


  final dateTimeWithTime = DateTime.utc(
      date.year,
      date.month,
      date.day,
      8,    // hour
      22,   // minute
      51,   // second
      418   // millisecond
  );


  return dateTimeWithTime.toIso8601String(); // returns with 'Z'
}
String convertToIso8601(String inputDate) {
  // Parse and add 1 day
  final date = DateFormat('MMM dd, yyyy').parse(inputDate).add(Duration(days: 1));

  // Return ISO 8601 formatted string in UTC
  return date.toUtc().toIso8601String();
}
String formatToReadableDate(String isoDate) {
  final date = DateTime.parse(isoDate).toLocal(); // convert to local time if needed
  return DateFormat('MMM dd, yyyy').format(date);
}

String parse400Error(String body) {
  try {
    final decoded = json.decode(body);
    if (decoded is Map) {
      if (decoded.containsKey('errors')) {
        final errors = decoded['errors'];
        if (errors is Map) {
          final List<String> messages = [];
          errors.forEach((key, val) {
            if (val is List) {
              messages.addAll(val.map((e) => e.toString()));
            } else if (val is Map) {
              val.forEach((k, v) {
                if (v is List) {
                  messages.addAll(v.map((e) => e.toString()));
                } else {
                  messages.add(v.toString());
                }
              });
            } else {
              messages.add(val.toString());
            }
          });
          if (messages.isNotEmpty) {
            return messages.join('\n');
          }
        } else if (errors is List) {
          return errors.map((e) => e.toString()).join('\n');
        } else {
          return errors.toString();
        }
      }
      if (decoded.containsKey('message')) {
        final msg = decoded['message'];
        if (msg is List) {
          return msg.map((e) => e.toString()).join('\n');
        }
        return msg.toString();
      }
      if (decoded.containsKey('error')) {
        final err = decoded['error'];
        return err.toString();
      }
      if (decoded.containsKey('title')) {
        return decoded['title'].toString();
      }
    }
  } catch (_) {}
  return body;
}