import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class StorageService {
  static final StorageService _singleton = StorageService._internal();

  factory StorageService() {
    return _singleton;
  }

  StorageService._internal();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String?> uploadFile({
    required String filePath,
    required String fileRef,
  }) async {
    File file = File(
      filePath,
    );
    try {
      firebase_storage.TaskSnapshot storageTaskSnapshot = await storage
          .ref('$fileRef/${file.path.split('/').last}')
          .putFile(file);

      return await storageTaskSnapshot.ref.getDownloadURL();
    } on firebase_core.FirebaseException catch (error) {
      debugPrint('$error');
    }
    return null;
  }
}
