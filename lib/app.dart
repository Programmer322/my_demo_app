import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/app_routes.dart';

Widget createApp(){
  return GetMaterialApp(
    initialRoute: Routes.INIIAL,
    getPages: AppPages.pages,
  );
}
appShowToast(String msg){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0x77000000),
    textColor: Colors.white,
    fontSize: 14,

  );}