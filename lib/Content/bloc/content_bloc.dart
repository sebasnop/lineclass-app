import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/repository/content_storage_repository.dart';
import 'package:lineclass/Content/repository/contents_firestore_repository.dart';

class ContentBloc implements Bloc{

  /// FIREBASE STORAGE
  final _contentStorageRepository = ContentStorageRepository();

  Future<StorageUploadTask> uploadFile(String path, File file) => _contentStorageRepository.uploadFile(path, file);


  /// FIREBASE FIRESTORE
  final _contentsFirestoreRepository = ContentsFirestoreRepository();

  Future <void> createContent(Content content) => _contentsFirestoreRepository.createContent(content);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}