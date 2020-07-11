import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ContentStorageAPI {
  final StorageReference _storageReference = FirebaseStorage.instance.ref();

  Future<StorageUploadTask> uploadFile(String path, File file) async{
    return _storageReference.child(path).putFile(file);
  }

  Future <String> uploadFileNew(String path, File _file) async {

    StorageReference reference = _storageReference.child(path);
    StorageUploadTask uploadTask = reference.putFile(_file);

    await uploadTask.onComplete;

    print('File Uploaded');

    return reference.getDownloadURL();

  }

}