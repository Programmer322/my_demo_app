import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/pages/dairy/logic.dart';
import 'package:my_demo_app/pages/dairy/view.dart';
import 'package:my_demo_app/pages/post/logic.dart';
import 'package:my_demo_app/pages/post/view.dart';
import 'package:my_demo_app/pages/todo_list/view.dart';
import 'package:my_demo_app/pages/user/view.dart';

import '../../AppColors.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final logicDairy=Get.put(DairyLogic());
  final logicPost=Get.put(PostLogic());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.lightPrimary,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(0),
          decoration:  ShapeDecoration(
            color: AppColors.lightPrimary,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFFCCD2B7)),
              borderRadius: BorderRadius.circular(7),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          height:80,
          child: const TabBar(
            labelStyle: TextStyle(height: 1, fontSize: 12),
            labelColor: AppColors.primary,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.edit_calendar,size: 30,
                ),
                text: '日记',
              ),
              Tab(
                icon: Icon(Icons.list_alt_outlined,size: 30,),
                text: '清单',
              ),
              Tab(
                icon: Icon(Icons.podcasts_outlined,size: 30,),
                text: '发布',
              ),
              Tab(
                icon: Icon(Icons.person_2_outlined,size: 30,),
                text: '我的',
              ),
            ],
          ),
        ),

        body: TabBarView(
          children:[
            DairyPage(),
            TodoListPage(),
            PostPage(),
            UserPage()
          ],
        ),
      ),
    );
  }
}







