import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<List<File>> pickImages() async {
  List<File> productImages = [];
  try {
    FilePickerResult? imagesFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true
    );
    if (imagesFiles != null && imagesFiles.files.isNotEmpty){
  for (int i=0; i<imagesFiles.files.length; i++){
    productImages.add(File(imagesFiles.files[i].path!));
  }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return productImages;
}
