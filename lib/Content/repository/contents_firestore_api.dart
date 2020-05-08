// Crear un contenido
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Content/model/content.dart';

class ContentsFirestoreAPI {

  final courses = "contents";
  final Firestore _db = Firestore.instance;

  Future <void> createContent(Content content) async {
    CollectionReference refContents = _db.collection(courses);

    await refContents.add({
      'id': content.id,
      'title': content.title,
      'description': content.description,
      'type': content.type,
      'urlFiles': content.urlFiles
    }).then((DocumentReference dr) {

      String getId = dr.documentID;
      dr.updateData({
        'id': getId
      });

    }
    );
  }

}