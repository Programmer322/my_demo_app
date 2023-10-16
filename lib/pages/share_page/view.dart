import 'dart:io';
import 'dart:typed_data';
import 'dart:ui'as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../AppColors.dart';
import '../../app.dart';
import '../dairy/logic.dart';
import 'logic.dart';

class SharePagePage extends StatelessWidget {
  SharePagePage({Key? key}) : super(key: key);

  final logic = Get.find<SharePageLogic>();
  final logicFore = Get.find<DairyLogic>();

  final GlobalKey repaintWidgetKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Color foregroundColor =logic.backgroundColor.computeLuminance()>0.5?Colors.black:Colors.white;
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(title: Text('分享愿望',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),backgroundColor: AppColors.primary,
      centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height:900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              Center(
                child: RepaintBoundary(
                  key: repaintWidgetKey,
                  child: Container(
                    width: 331.60,
                    height: 700,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: logic.backgroundColor),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: 0,
                          bottom: 0,
                          right: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${Get.arguments}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:foregroundColor,
                                      fontSize: 15,

                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 30.06,
                            height: 30.06,
                            child: Icon(Icons.settings_system_daydream_rounded,color: foregroundColor,size: 30,),
                          ),
                        ),
                        // Positioned(
                        //     right: 0,
                        //     top: 0,
                        //     child:Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: SvgPicture.asset('assets/images/qr_code.svg',color: foregroundColor,),
                        //     )
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await SharePosterUtils.savePosterImage(repaintWidgetKey);
                          },
                          icon: const Icon(
                            Icons.download_for_offline,
                            color:AppColors.primary,
                            size: 65,
                          )),
                    ],
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
class SharePosterUtils {

  static Future<ByteData?> getWidgetToImageByteData(
      GlobalKey repaintKey) async {
    PermissionStatus status = await Permission.storage.status;
    print(status.isGranted);
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    BuildContext? buildContext = repaintKey.currentContext;
    print(buildContext);
    if (null != buildContext) {
      RenderRepaintBoundary? boundary =
      buildContext.findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        EasyLoading.show(status: '保存失败, == >>> 获取 image.toByteData 失败');
        return null;
      } else {
        return byteData;
      }
    }
    return null;
  }

  static Future<String?> getImageFilePath(GlobalKey repaintKey) async {
    ByteData? byteData = await SharePosterUtils.getWidgetToImageByteData(repaintKey);
    if (byteData == null) {
      print('获取 byteData 失败 ');
      return null;
    }
    Uint8List imageByte = byteData.buffer.asUint8List();
    var tempDir = await getTemporaryDirectory();
    var file = await File('${tempDir
        .path}/image_${DateTime.now().millisecond}.jpg').create();
    file.writeAsBytesSync(imageByte);
    return file.path;
  }


  static savePosterImage(GlobalKey repaintKey) async {
    ByteData? byteData = await SharePosterUtils.getWidgetToImageByteData(repaintKey);
    if (byteData == null) {
      print('获取 byteData 失败 ');
      return;
    }
    final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    if (result['isSuccess']) {
      appShowToast('保存成功');
    } else {
      appShowToast('保存失败');
    }
  }

}