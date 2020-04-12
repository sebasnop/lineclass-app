import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/Publication/repository/publications_firestore_api.dart';
import 'package:lineclass/Publication/repository/publications_firestore_repository.dart';

class PublicationBloc implements Bloc {

  final _publicationsFirestoreRepository = PublicationsFirestoreRepository();

  Future <void> createPublication(Publication publication) =>
      _publicationsFirestoreRepository.createPublication(publication);

  Stream<QuerySnapshot> publicationsListStream (DocumentReference courseReference) {

    Stream <QuerySnapshot> publications = Firestore.instance.collection(PublicationsFirestoreAPI().publications).where(
        "course", isEqualTo: courseReference).snapshots();

    return publications;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}