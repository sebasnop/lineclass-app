import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/repository/contents_firestore_api.dart';

class ContentsFirestoreRepository {

  final _contentsFirestoreAPI = ContentsFirestoreAPI();

  Future <void> createContent(Content content) => _contentsFirestoreAPI.createContent(content);

}