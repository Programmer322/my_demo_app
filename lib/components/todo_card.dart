import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/AppColors.dart';
import 'package:my_demo_app/app.dart';
import 'package:my_demo_app/components/app_text_field.dart';
import 'package:my_demo_app/model/todo.dart';

import '../core/database/provider/todo_list_table.dart';
import '../main.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool flag=true;
  @override
  Widget build(BuildContext context) {
    return flag?
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          TextEditingController contentEditingController=TextEditingController();
          contentEditingController.text=widget.todo.content;
          String update=widget.todo.content;
          Get.bottomSheet(Container(
            width: double.infinity,
            height: 250,
            decoration: ShapeDecoration(
              color: AppColors.lightPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16)),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 15,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextField(hint: 'Todo', labelText: '清单',controller: contentEditingController,onChanged: (val){
                      update=val;
                    },),
                    SizedBox(height: 25,),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.48, color: Color(0xFFCCD2B7)),
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          onPressed: () async {
                            TodoListTableProvider todoTableProvider =
                            TodoListTableProvider();
                            todoTableProvider.getDatabase();
                            Map mapAccount = box.read('account');
                            Todo updatedTodo = Todo(
                                userId: widget.todo.userId,
                                content: update,
                                pubTime: widget.todo.pubTime,
                                id: widget.todo.id,
                                status: widget.todo.status);
                            var res = await todoTableProvider.updateTodo(updatedTodo);
                            Get.back();
                            setState(() {
                              widget.todo.content=update;
                            });
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save_as,color: AppColors.textOrIcon,),
                          SizedBox(width: 25,),
                          Text('保存'),
                        ],
                      )),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textOrIcon,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.48, color: Color(0xFFCCD2B7)),
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          onPressed: () async {
                            TodoListTableProvider todoTableProvider =
                            TodoListTableProvider();
                            todoTableProvider.getDatabase();
                            var res = await todoTableProvider.deleteTodo(widget.todo.id);
                            Get.back();
                            setState(() {
                              flag=false;
                            });
                          }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_forever_outlined,color: Colors.redAccent,),
                              SizedBox(width: 25,),
                              Text('删除',style: TextStyle(color: Colors.redAccent),),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ));

        },
        child: Container(
          width: 361,
          padding: const EdgeInsets.only(
            top: 15,
            left: 22,
            right: 11,
            bottom: 15,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: AppColors.primary.withOpacity(0.5)),
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
              color: AppColors.lightPrimary),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(value: map2[widget.todo.status], onChanged:(val) async {
                TodoListTableProvider todoTableProvider =
                TodoListTableProvider();
                todoTableProvider.getDatabase();
                Map mapAccount = box.read('account');
                Todo updatedTodo = Todo(
                    userId: mapAccount['id'],
                    content: widget.todo.content,
                    pubTime: widget.todo.pubTime,
                    id: widget.todo.id,
                    status: widget.todo.status=='pending'?'ok':'pending');
                var res = await todoTableProvider.updateTodo(updatedTodo);
                setState(() {
                  widget.todo.status=widget.todo.status=='pending'?'ok':'pending';
                });
              }),
              Expanded(
                child: Text(
                  widget.todo.content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 75,
                height: 35,
                child: ElevatedButton(
                  onPressed: () async {
                    if(widget.todo.status=='pending'){
                      TodoListTableProvider todoTableProvider =
                          TodoListTableProvider();
                      todoTableProvider.getDatabase();
                      Map mapAccount = box.read('account');
                      Todo updatedTodo = Todo(
                          userId: mapAccount['id'],
                          content: widget.todo.content,
                          pubTime: widget.todo.pubTime,
                          id: widget.todo.id,
                          status: 'ok');
                      var res = await todoTableProvider.updateTodo(updatedTodo);
                      setState(() {
                        widget.todo.status = 'ok';
                      });
                    }else{
                      appShowToast('您已经完成了这一项哦');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary),
                  child: Text(
                    map[widget.todo.status]!,
                    style: TextStyle(
                      color: AppColors.textOrIcon,
                      fontSize: 12,
                      fontFamily: 'MiSans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ):Container();
  }

  static const map = {'pending': "完成", 'ok': "已完成"};
  static const map2 = {'pending': false, 'ok': true};
}
