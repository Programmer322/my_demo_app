
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';

import '../app.dart';

class ZoomableImage extends StatefulWidget {
  const ZoomableImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  final ValueNotifier<PhotoViewController> controller=ValueNotifier<PhotoViewController>(PhotoViewController());
  final ValueNotifier<double> scaleNotifier=ValueNotifier(1.0);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.back();
      },

      child: PhotoView(imageProvider: FileImage(File(widget.imageUrl)),
        scaleStateController: PhotoViewScaleStateController(),
        controller: controller.value,
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        minScale: PhotoViewComputedScale.contained*0.8,
        maxScale: PhotoViewComputedScale.covered*2,
        enableRotation: true,
      ),
    );
  }
}