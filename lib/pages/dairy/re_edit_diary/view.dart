import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_demo_app/app_routes.dart';
import '../../../AppColors.dart';
import '../../../app.dart';
import '../../../core/database/provider/diary_table_provider.dart';
import '../../../main.dart';
import '../../../model/diary.dart';
import 'logic.dart';

class ReEditDiaryPage extends StatefulWidget {
  ReEditDiaryPage({Key? key, required this.diary}) : super(key: key);
  final Diary diary;

  @override
  State<ReEditDiaryPage> createState() => _ReEditDiaryPageState();
}

class _ReEditDiaryPageState extends State<ReEditDiaryPage> {
  final logic = Get.put(ReEditDiaryLogic());

  File? imageSelect;
  TextEditingController titleEditingController=TextEditingController();
  TextEditingController contentEditingController=TextEditingController();
  late String? picUrl;
  @override
  void initState() {
    imageSelect=widget.diary.imagePath==null?null:File(widget.diary.imagePath!);
    logic.content=widget.diary.content;
    logic.title=widget.diary.title;
    titleEditingController.text=widget.diary.title;
    contentEditingController.text=widget.diary.content;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '重新编辑',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppColors.darkPrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleEditingController,
                onChanged: (val) {
                  logic.title = val;
                },
                maxLength: 20,
                decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  hintText: '标题（20字内）',
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: imageSelect==null
                            ? IconButton(
                            onPressed: () async {
                              final ImagePicker imagePicker = ImagePicker();
                              XFile? image1 = await imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 1080,
                                  maxWidth: 1080
                              );
                              if (image1 != null) {
                                setState(() {
                                  imageSelect=File(image1.path);
                                });
                              }else{
                                appShowToast('已取消');
                              }
                            },
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 70,
                            ))
                            :Container(
                          width: 70,
                          height: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: FileImage(imageSelect!),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                          ),
                        ),
                      ),
                      imageSelect!=null
                          ?Positioned(
                        top: 0,
                        right: 0,
                        child:GestureDetector(
                            onTap: (){
                              setState(() {
                                imageSelect=null;
                              });
                            },
                            child: Icon(Icons.cancel,color: Colors.redAccent,size: 20,)) ,
                      )
                          :Container(),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 400,
                child: TextField(
                  controller: contentEditingController,
                  onChanged: (val) {
                    logic.content = val;
                  },
                  maxLength: 1000,
                  maxLines: 50,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '正文（1000字内）',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () async {
                    Map account=box.read('account');
                    Diary diary = Diary(userId: account['id'], title:logic.title, content: logic.content, pubTime: widget.diary.pubTime, id: widget.diary.id,imagePath: imageSelect?.path);
                    print(diary.toMap());
                    DiaryTableProvider diaryTableProvider= DiaryTableProvider();
                    diaryTableProvider.getDatabase();
                    await diaryTableProvider.updateDiary(diary);
                    appShowToast('保存成功');
                    Get.offAllNamed(Routes.HOME);
                  }, child: Text('保存'),style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.48, color: Color(0xFFCCD2B7)),
                      borderRadius: BorderRadius.circular(9),
                    ),
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
