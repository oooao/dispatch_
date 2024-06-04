import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';

class ImageHelper {
  static Future<String> pickUserPhoto() async {
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: const Color(0xffff0f50)),
        cropConfig: CropConfig(enableCrop: false, width: 1, height: 1));

    if (listImagePaths.isNotEmpty) {
      Media media = listImagePaths.first;
      final pickedFile = File(media.path!);
      final bytes = await pickedFile.readAsBytes();
      String img64 = base64Encode(bytes);
      return img64;
    }
    return "";
  }

  static Future<List<String>> pickPhotos({int count = 10}) async {
    List<String> photos = [];
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: count,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: const Color(0xffff0f50)),
        cropConfig: CropConfig(enableCrop: false, width: 16, height: 9));
    for (Media media in listImagePaths) {
      final pickedFile = File(media.path!);
      final bytes = await pickedFile.readAsBytes();
      String img64 = base64Encode(bytes);
      photos.add(img64);
    }
    return photos;
  }

  static Image imageFromBase64String(String base64String,
      {double width = 0, double height = 0}) {
    if (width != 0 && height != 0) {
      return Image.memory(base64Decode(base64String),
          width: width, height: height);
    }
    return Image.memory(base64Decode(base64String));
  }

/*
  static Future<PickedFile> getBookCover() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 300, maxHeight: 400);
    return Future.value(pickedFile);
  }

  static Future<DecorationImage> getImage(PickedFile pickedFile) {
    DecorationImage image = DecorationImage(
      image: FileImage(File(pickedFile.path)),
    );
    return Future.value(image);
  }
*/

  /*
  static Future<String> uploadBookCover(
      PickedFile pickedFile, String bookid) async {
    firebase_storage.UploadTask uploadTask;
    print("pickedFile: $pickedFile");
    String mimeType = mime(pickedFile.path)!;
    final String extension = extensionFromMime(mimeType)!;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Book')
        .child('$bookid.$extension');

    final metadata = firebase_storage.SettableMetadata(
        contentType: mimeType,
        customMetadata: {'picked-file-path': pickedFile.path});

    uploadTask = ref.putData(await pickedFile.readAsBytes(), metadata);
    firebase_storage.TaskSnapshot snapshot =
        await uploadTask.whenComplete(() => {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  */
}
