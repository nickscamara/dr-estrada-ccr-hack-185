import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // Returns a [File] object pointing to the image that was picked.
  Future<File> pickImage({@required ImageSource source}) async {
    return ImagePicker.pickImage(source: source);
  }
  Future<File> galleryView() async {
    return ImagePicker.pickImage(source: ImageSource.gallery);
  }

   
}