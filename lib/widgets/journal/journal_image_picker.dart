import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

Future<File> takeImage() async {
  File imageTaken;
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickImage(
    source: ImageSource.camera,
  );
  
  imageTaken = File(imageFiles!.path);

  return imageTaken;
}
