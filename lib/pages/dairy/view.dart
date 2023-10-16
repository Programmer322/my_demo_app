import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/components/home_page_dairy.dart';
import 'package:my_demo_app/main.dart';

import '../../AppColors.dart';
import '../../core/database/provider/diary_table_provider.dart';
import '../../model/diary.dart';
import 'logic.dart';

class DairyPage extends StatelessWidget {
  DairyPage({Key? key}) : super(key: key);
  final logic = Get.find<DairyLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(
        title: Text(
          '小程的日记本',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppColors.darkPrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: ShapeDecoration(
                          color: AppColors.darkPrimary,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.50, color: Color(0xFFCCD2B7)),
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
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: ShapeDecoration(
                                  color: AppColors.lightPrimary,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFCCD2B7)),
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
                              ),
                            ),
                            Center(
                              child: Text(
                                '${DateTime.now().month}',
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: ShapeDecoration(
                          color: AppColors.darkPrimary,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.50, color: Color(0xFFCCD2B7)),
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
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: ShapeDecoration(
                                  color: AppColors.lightPrimary,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFCCD2B7)),
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
                              ),
                            ),
                            Center(
                              child: Text(
                                '${DateTime.now().day}',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: ShapeDecoration(
                                color: AppColors.darkPrimary,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.50, color: Color(0xFFCCD2B7)),
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
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: ShapeDecoration(
                                        color: AppColors.lightPrimary,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFCCD2B7)),
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
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${DateTime.now().day}',
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 45,
                    width: 75,
                    decoration: ShapeDecoration(
                      color: AppColors.darkPrimary,
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
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 35,
                            width: 65,
                            decoration: ShapeDecoration(
                              color: AppColors.lightPrimary,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFFCCD2B7)),
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
                          ),
                        ),
                        Center(
                          child: Text(
                            '${map[DateTime.now().weekday]}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: Get.height * 0.44,
                    width: 350,
                    decoration: ShapeDecoration(
                      color: AppColors.darkPrimary,
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
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: Get.height * 0.44 - 10,
                            width: 340,
                            decoration: ShapeDecoration(
                              color: AppColors.lightPrimary,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFFCCD2B7)),
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:FutureBuilder(future: getData(), builder:  (context,snapshot){
                            if(snapshot.connectionState==ConnectionState.done){
                              if(snapshot.hasError){
                                return const Center(child: Text('加载失败,请重试',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'MiSans',
                                  fontWeight: FontWeight.w600,
                                ),),);
                              }else{
                                List<HomePageDairy> list=[];
                                for(var item in logic.diaryList){
                                  list.add(HomePageDairy(diary: item));
                                }
                                return  list.isEmpty?
                                    Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/flo.svg',color: AppColors.primary.withOpacity(0.5),),
                                          SizedBox(height: 15,),
                                          Text('日记列表为空\n请前往发布页添加',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: AppColors.primary.withOpacity(0.5)),),
                                        ],
                                      ),
                                    )
                                    :ListView(
                                  children: [
                                    Text(
                                      '您的日记',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.secondaryText),
                                    ),
                                    for(var item in logic.diaryList )
                                      HomePageDairy(diary: item)
                                  ],
                                );}}else{
                              return Center(child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(),
                              ));
                            }})
                          ,
                         
                        )
                      ],
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
getData()async{
  DiaryTableProvider diaryTableProvider= DiaryTableProvider();
  diaryTableProvider.getDatabase();
  Map map=box.read('account');
  var res = await diaryTableProvider.getDiariesByUserId(map['id']);
  logic.diaryList=res.reversed.toList();
  return 'ok';
}
  final Map map = {
    1: '星期一',
    2: '星期二',
    3: '星期三',
    4: '星期四',
    5: '星期五',
    6: '星期六',
    7: '星期日',
  };
}
