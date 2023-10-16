import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/app_routes.dart';
import 'package:my_demo_app/components/zoomable_image.dart';
import 'package:my_demo_app/core/database/provider/diary_table_provider.dart';
import 'package:my_demo_app/model/diary.dart';
import 'package:my_demo_app/pages/dairy/re_edit_diary/view.dart';

import '../AppColors.dart';

class HomePageDairy extends StatefulWidget {
  HomePageDairy({super.key, required this.diary});
  final Diary diary;

  @override
  State<HomePageDairy> createState() => _HomePageDairyState();
}

class _HomePageDairyState extends State<HomePageDairy> {
  bool flag=true;
  @override
  Widget build(BuildContext context) {
    return flag?Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Get.bottomSheet(Container(
            width: double.infinity,
            height: double.infinity,
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
                    Text(
                      widget.diary.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.diary.pubTime.year.toString() +
                            '/' +
                            widget.diary.pubTime.month.toString() +
                            '/' +
                            widget.diary.pubTime.day.toString()+'---'+map[widget.diary.pubTime.weekday],
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.secondaryText,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    widget.diary.imagePath==null?Container():GestureDetector(
                      onTap: (){
                        showDialog<void>(
                          context: context,
                          barrierColor: Colors.black,
                          builder: (BuildContext dialogContext) {
                            return ZoomableImage(
                              imageUrl: widget.diary.imagePath!,
                            );
                          },
                        );
                      },
                      child: Container(
                          height: 150,
                          width: 250,
                          child: Image.file(File(widget.diary.imagePath!),fit: BoxFit.cover,)),
                    ),
                    widget.diary.imagePath==null?Container():SizedBox(height: 25,),
                    Row(
                      children: [
                        Expanded(child: Text(widget.diary.content,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary
                        ),))
                      ],
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.48, color: Color(0xFFCCD2B7)),
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          onPressed: (){
                        Get.toNamed(Routes.SHAREPAGE,arguments: widget.diary.content);
                      }, child: Text('生成图片')),
                    ),
                    SizedBox(height: 25,),

                  ],
                ),
              ),
            ),
          ));

        },
        child: Container(
            width: 300,
            decoration: ShapeDecoration(
              color: AppColors.primary.withOpacity(0.5),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${widget.diary.pubTime.day} ${map[widget.diary.pubTime.weekday]}',
                          style: TextStyle(
                              fontSize: 16, color: AppColors.textOrIcon),
                        ),
                        Text(
                          '${widget.diary.pubTime.year}-${widget.diary.pubTime.month}-${widget.diary.pubTime.day}',
                          style: TextStyle(color: AppColors.textOrIcon),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      width: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Expanded(
                                child: Text('${widget.diary.content}',
                                    overflow: TextOverflow.ellipsis, maxLines: 2),
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.to(ReEditDiaryPage(diary: widget.diary));
                                  },
                                  icon: Icon(
                                    Icons.edit_calendar,
                                    size: 20,
                                    color: AppColors.darkPrimary,
                                  ),
                                  color: AppColors.accent,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    DiaryTableProvider d = DiaryTableProvider();
                                    await d.deleteDiary(widget.diary.id);
                                    setState(() {
                                      flag=false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete_forever_outlined,
                                    size: 20,
                                  ),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    ):Container();
  }

  final Map map = {
    1: '周一',
    2: '周二',
    3: '周三',
    4: '周四',
    5: '周五',
    6: '周六',
    7: '周日',
  };
}
