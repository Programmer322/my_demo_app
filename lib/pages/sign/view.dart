import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/AppColors.dart';
import 'package:my_demo_app/components/app_text_field.dart';
import 'package:my_demo_app/core/database/provider/user_table_provider.dart';
import 'package:my_demo_app/core/database/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

import 'logic.dart';

class SignPage extends StatelessWidget {
  SignPage({Key? key}) : super(key: key);

  final logic = Get.find<SignLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.lightPrimary,
        appBar: AppBar(
          title: Text(
            "注册",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: AppColors.darkPrimary,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    '填写信息注册吧',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 15,),
                  AppTextField(
                    labelText: '手机号',
                    hint: '手机号',
                    onChanged: (val) {
                      logic.phoneNumber = val;
                    },
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  AppTextField(
                    hint: '密码',
                    onChanged: (val) {
                      logic.password = val;
                    }, labelText: '密码',
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  AppTextField(
                    hint: '用户名',
                    onChanged: (val) {
                      logic.username = val;
                    }, labelText: '用户名',
                  ),
                  Spacer(),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        logic.send();
                      },
                      child: Text(
                        '注册',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.textOrIcon,
                        backgroundColor: AppColors.darkPrimary,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
