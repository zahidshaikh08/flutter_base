import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base/utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets.dart';

class ImageDialog extends StatelessWidget {
  final String? title;
  final BoxDecoration? decoration;
  final Function onPick;

  const ImageDialog({
    Key? key,
    required this.onPick,
    this.title,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Texts(title ?? 'Select Image'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                pick(context, ImageSource.camera);
              },
              child: Container(
                height: 100,
                decoration: decoration ??
                    BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                child: const Center(
                  child: Texts(
                    "Camera",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: InkWell(
              onTap: () async {
                pick(context, ImageSource.gallery);
              },
              child: Container(
                height: 100,
                decoration: decoration ??
                    BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                child: const Center(
                  child: Texts(
                    "Gallery",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: const Texts('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void pick(BuildContext context, ImageSource source) async {
    try {
      Navigator.pop(context);
      final pickedFile = await AppUtils.pickImage(source: source);

      if (pickedFile != null) {
        String fileName = "";

        if (source == ImageSource.camera) {
          var now = DateTime.now();
          fileName =
              "Image_${now.year}_${now.month}_${now.day}_${now.millisecondsSinceEpoch}.jpg";
        } else {
          fileName =
              pickedFile.path.substring(pickedFile.path.lastIndexOf("/"));
          fileName = fileName
              .toString()
              .substring(1)
              .replaceAll("image_picker", "Image_");
        }
        onPick(fileName, pickedFile.path);
      }
    } catch (e) {
      log("exception in pick image ==>>> ${e.toString()}");
    }
  }
}
