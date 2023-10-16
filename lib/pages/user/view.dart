import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/app_routes.dart';
import 'package:my_demo_app/main.dart';

import '../../AppColors.dart';
import 'logic.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final logic = Get.put(UserLogic());
  final accountMap = box.read('account');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(
        title: Text(
          '小程的清单',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppColors.darkPrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(

          children: [
            Spacer(),
            GestureDetector(
              onTap: (){

              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    foregroundImage:AssetImage('assets/images/por.jpg'),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Text(accountMap['username'],style:TextStyle(
              color: Color(0xFF2F2F2F),
              fontSize: 30,
              fontFamily: 'MiSans',
              fontWeight: FontWeight.w600,
              height: 0.07,
              letterSpacing: -0.43,
            ),),
            Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.48, color: Color(0xFFCCD2B7)),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  onPressed: () {
                    box.erase();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Text('退出登录')),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
