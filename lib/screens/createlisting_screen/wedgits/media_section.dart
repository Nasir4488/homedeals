import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/utils/textTheams.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cores/property_controller.dart';
import '../../../utils/constants.dart';

class MediaSection extends StatefulWidget {
  const MediaSection({Key? key}) : super(key: key);
  @override
  State<MediaSection> createState() => _MediaSectionState();
}
class _MediaSectionState extends State<MediaSection> {
  var imageController = Get.put(PropertyController());
  final picker = ImagePicker();
  void _imgFromGallery() async {
    List<XFile>? files = await picker.pickMultiImage(
      imageQuality: 50,
    );
    if (files != null) {
      imageController.addImages(files);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
      padding: EdgeInsets.all(20),
      width: screenWidth,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Media", style: mediamheading),
          ),
          Divider(),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload Images",
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 10),
              InkWell(
                onTap: _imgFromGallery,
                child: Container(
                  width: screenWidth,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 0.3,
                      color: Colors.grey.shade500,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 70,
                        child: Image.asset("assets/icons/upload.png",
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Expanded(
            child: Obx(
              () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemCount: imageController.images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: Image.memory(
                          imageController.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 140,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon:
                                Icon(Icons.cancel, color: Colors.red, size: 18),
                            onPressed: () {
                              // imageController.removeImage(index);
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
