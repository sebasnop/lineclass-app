import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Content/model/content.dart';

class ContentsFirestoreAPI {

  final collectionName = "contents";
  final Firestore _db = Firestore.instance;

  Future <DocumentReference> createContentReference(Content content) async {
    CollectionReference refContents = _db.collection(collectionName);

    return await refContents.add({
      'id': content.id,
      'title': content.title,
      'description': content.description,
      'type': content.type,
      'urlFile': content.urlFile
    });
  }

  Future <void> setContentId(DocumentReference contentReference) async {

    await contentReference.setData({
      'id': contentReference.documentID
      },
        merge: true
    );

  }

}