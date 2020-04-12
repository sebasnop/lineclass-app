import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Publication/model/publication.dart';

class PublicationsFirestoreAPI {

  final publications = "publications";
  final Firestore _db = Firestore.instance;

  // Crear un curso
  Future <void> createPublication(Publication publication) async {

    CollectionReference refPublications = _db.collection(publications);

    await refPublications.add({
      'id': publication.id,
      'title' : publication.title,
      'description': publication.description,
      'publisher': publication.publisher,
      'course': publication.course,
      'publicationDate': publication.publicationDate
    }).then( (DocumentReference dr) {

      String getId = dr.documentID;

      dr.updateData({
        'id': getId
      });

    }
    );

  }

}