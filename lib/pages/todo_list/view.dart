import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/components/todo_card.dart';
import 'package:my_demo_app/core/database/provider/todo_list_table.dart';

import '../../AppColors.dart';
import '../../main.dart';
import '../../model/todo.dart';
import 'logic.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final logic = Get.put(TodoListLogic());
  getData()async{
    logic.todoList=[];
    logic.todoListPending=[];
    logic.todoListCompleted=[];
    TodoListTableProvider todoListTableProvider= TodoListTableProvider();
    todoListTableProvider.getDatabase();
    Map map=box.read('account');
    var res = await todoListTableProvider.getTodoByUserId(map['id']);
    logic.todoList=res;
    for(var item in logic.todoList){
      if(item.status=='pending'){
        logic.todoListPending.add(item);
      }else{
        logic.todoListCompleted.add(item);
      }
    }
  }
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
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
    if(snapshot.connectionState==ConnectionState.done){
    if(snapshot.hasError){
      return const Center(child: Text('加载失败,请重试',style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'MiSans',
        fontWeight: FontWeight.w600,
      ),),);
    }else{
      return logic.todoList.isEmpty?Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/flo.svg',color: AppColors.primary.withOpacity(0.5),),
          SizedBox(height: 15,),
          Text('清单列表为空\n请前往发布页添加',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColors.primary.withOpacity(0.5)),),
        ],
      ),):ListView(
        children: [
          for(Todo item in logic.todoListPending)
              TodoCard(todo: item,),
          for(Todo item in logic.todoListCompleted)
            TodoCard(todo: item)
        ],
      );
    }
    }else{
      return const Center(child: CircularProgressIndicator());
    }
    },
      ),
    );
  }
}
