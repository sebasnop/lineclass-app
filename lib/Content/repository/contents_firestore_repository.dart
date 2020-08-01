import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/repository/contents_firestore_api.dart';

class ContentsFirestoreRepository {

  final _contentsFirestoreAPI = ContentsFirestoreAPI();

  Future <DocumentReference> createContentReference(Content content) => _contentsFirestoreAPI.createContentReference(content);
  Future <void> setContentId(DocumentReference contentReference) => _contentsFirestoreAPI.setContentId(contentReference);

}