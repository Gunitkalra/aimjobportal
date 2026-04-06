import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

int totalSeconds=80;

Map<String,dynamic> userRegisterData={};
Map<String,dynamic> classdata={};
RegExp emailPassword = RegExp(r'[A-Za-z0-9@._-]');
String userTokens="";
String fcmToken="";
Map<dynamic,dynamic> userModel={};
String userAddress="";
var userLat="";
var datumid="";
String userId="";
String locationId="";
String locationName="";
String locationPin="";
String planId="";
BuildContext context1=context1;
String adminschoolid="";
String adminTokenis="";
var iswebpaymentdone= false.obs;
String franchiseid ="";
String franchisetoken ="";
String reportIds ="";
String orderIdforverify ="";


String deliveryboyid=userId;
// String deliveryboyid="67e7ebb4667c2d0972efe6b7";
String deliveryboytoken=userTokens;
// String customerfirstname="";
// String customerlastname="";
// String customermobile="";
// String customeremail="";
// String customeraddress="";
//service order
// String appliveurl="https://play.google.com/store/apps/details?id=contri.app.in";


