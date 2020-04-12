
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/Publication/repository/publications_firestore_api.dart';
import 'package:lineclass/Publication/ui/widgets/publication_card.dart';
import 'package:lineclass/User/model/user.dart';

class PublicationsFirestoreRepository {

  final _publicationsFirestoreAPI = PublicationsFirestoreAPI();

  Future <void> createPublication(Publication publication) =>
      _publicationsFirestoreAPI.createPublication(publication);

  List <PublicationCard> buildPublications(List<DocumentSnapshot> publicationsListSnapshot, User user)
  => _publicationsFirestoreAPI.buildPublications(publicationsListSnapshot, user);

}