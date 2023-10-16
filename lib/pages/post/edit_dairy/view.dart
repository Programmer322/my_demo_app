import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_demo_app/core/database/provider/diary_table_provider.dart';
import 'package:my_demo_app/main.dart';
import 'package:my_demo_app/model/diary.dart';

import '../../../AppColors.dart';
import '../../../app.dart';
import 'logic.dart';

class EditDairyPage extends StatefulWidget {
  EditDairyPage({Key? key}) : super(key: key);

  @override
  State<EditDairyPage> createState() => _EditDairyPageState();
}

class _EditDairyPageState extends State<EditDairyPage> {
  final logic = Get.find<EditDairyLogic>();

  File? imageSelect;

  late String? picUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '写日记',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: AppColors.darkPrimary,
          centerTitle: true,
        ),
        body:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
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
                      Diary diary = Diary(userId: account['id'], title:logic.title, content: logic.content, pubTime: DateTime.now(), id: -1,imagePath: imageSelect?.path);
                      print(diary.toMap());
                      DiaryTableProvider diaryTableProvider= DiaryTableProvider();
                      diaryTableProvider.getDatabase();
                      await diaryTableProvider.insertDiary(diary);
                      appShowToast('保存成功');
                      Get.back();
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
      ),
    );
  }
}
