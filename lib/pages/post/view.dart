import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/app_routes.dart';
import 'package:my_demo_app/model/todo.dart';

import '../../AppColors.dart';
import '../../app.dart';
import '../../components/app_text_field.dart';
import '../../core/database/provider/todo_list_table.dart';
import '../../main.dart';
import 'logic.dart';

class PostPage extends StatelessWidget {
  PostPage({Key? key}) : super(key: key);

  final logic = Get.find<PostLogic>();
  final Map map = {
    1: '周一',
    2: '周二',
    3: '周三',
    4: '周四',
    5: '周五',
    6: '周六',
    7: '周日',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '发布',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppColors.darkPrimary,
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightPrimary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.EDITDAIRY);
                  },
                  child: Container(
                    width: 361,
                    height: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: AppColors.primary.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.97, color: AppColors.darkPrimary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.edit_calendar,
                          color: AppColors.darkPrimary,
                          size: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '写日记',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                  color: AppColors.darkPrimary),
                            ),
                            SizedBox(height: 20,),
                            Text(
                                '今日：${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}---${map[DateTime.now().weekday]}',
                                style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.w500,fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    String todoContent='';
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          backgroundColor: AppColors.primary,
                          title: const Icon(
                            Icons.hail_sharp,
                            size: 40,
                            color: AppColors.textOrIcon,
                          ),
                          content: const Text(
                            '你有什么要做的写在下面吧',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textOrIcon,
                              fontSize: 14,
                              fontFamily: 'MiSans',
                              fontWeight: FontWeight.w500,
                              height: 1.50,
                            ),
                          ),
                          actions: <Widget>[
                            AppTextField(
                              labelText: 'Todo',
                              hint: '请输入内容',
                              onChanged: (val) {
                                todoContent=val;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  child: const SizedBox(
                                    width: 57,
                                    height: 20,
                                    child: Text(
                                      "取消",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.textOrIcon,
                                        fontSize: 14,
                                        fontFamily: 'MiSans',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                                  },
                                ),
                                TextButton(
                                  child: const SizedBox(
                                    width: 57,
                                    height: 20,
                                    child: Text(
                                      "保存",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.textOrIcon,
                                        fontSize: 14,
                                        fontFamily: 'MiSans',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if(todoContent!=''){
                                      Map account=box.read('account');
                                      Todo todo = Todo(userId: account['id'], content: todoContent, pubTime: DateTime.now(), id: -1);
                                      print(todo.toMap());
                                      TodoListTableProvider todoListTableProvider= TodoListTableProvider();
                                      todoListTableProvider.getDatabase();
                                      await todoListTableProvider.insertTodo(todo);
                                      appShowToast('保存成功');
                                      Get.back();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 361,
                    height: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: AppColors.primary.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.97, color: AppColors.darkPrimary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.library_add_check_rounded,
                          color: AppColors.darkPrimary,
                          size: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '列清单',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: AppColors.darkPrimary),
                            ),
                            SizedBox(width: 200,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
