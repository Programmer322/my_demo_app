import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/app_routes.dart';
import 'package:my_demo_app/core/database/provider/user_table_provider.dart';

import '../../AppColors.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: AppColors.lightPrimary,
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text('欢迎回来!',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: AppColors.textPrimary,
                      ),),
                      SizedBox(height: 15,),
                      Text('登录可继续操作',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.secondaryText,
                      ),),
                      SizedBox(height: 15,),
                      TextField(
                        onChanged: (val){
                          logic.phoneNumber=val;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.primary,
                            icon: Icon(Icons.login_sharp),
                            hintText: '手机号',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        onChanged: (val){
                          logic.password=val;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.primary,
                            icon: Icon(Icons.key),
                            hintText: '密码',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),

                      SizedBox(height: 15,),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                           logic.doLogin();
                          }, child: Text('登录',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,

                        ),),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.textOrIcon,
                            backgroundColor: AppColors.darkPrimary,
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Text('没有账号?',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.secondaryText,
                          ),),
                          SizedBox(width: 25,),
                          TextButton(onPressed: (){
                            Get.toNamed(Routes.SIGNUP);
                          }, child: Text('注册',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),),

                          ),
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
