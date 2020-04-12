
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/Publication/repository/publications_firestore_api.dart';

class PublicationsFirestoreRepository {

  final _publicationsFirestoreAPI = PublicationsFirestoreAPI();

  Future <void> createPublication(Publication publication) =>
      _publicationsFirestoreAPI.createPublication(publication);

}