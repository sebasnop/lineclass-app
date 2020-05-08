import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:lineclass/Content/repository/content_storage_api.dart';

class ContentStorageRepository{

  final _contentStorageAPI = ContentStorageAPI();

  Future<StorageUploadTask> uploadFile(String path, File file) => _contentStorageAPI.uploadFile(path, file);

}