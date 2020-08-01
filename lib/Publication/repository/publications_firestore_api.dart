import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/Publication/ui/widgets/publication_card.dart';
import 'package:lineclass/User/model/user.dart';

class PublicationsFirestoreAPI {

  final publications = "publications";
  final Firestore _db = Firestore.instance;

  // Crear una publicación
  Future <void> createPublication(Publication publication) async {

    CollectionReference refPublications = _db.collection(publications);

    await refPublications.add({
      'id': publication.id,
      'title' : publication.title,
      'description': publication.description,
      'publisher': publication.publisher,
      'course': publication.course,
      'publicationDate': publication.publicationDate,
      'contents': publication.contents
    }).then( (DocumentReference dr) {

      String getId = dr.documentID;

      dr.updateData({
        'id': getId
      });

    }
    );

  }

  Publication buildPublication (DocumentSnapshot publicationSnapshot){

    Publication publication = Publication(
      id: publicationSnapshot.data["id"],
      title: publicationSnapshot.data["title"],
      description: publicationSnapshot.data["description"],
      publicationDate: publicationSnapshot.data["publicationDate"],
      publisher: publicationSnapshot.data["publisher"],
      course: publicationSnapshot.data["course"]
    );

    return publication;

  }

  List <PublicationCard> buildPublications(List<DocumentSnapshot> publicationsListSnapshot, User user) {

    List <PublicationCard> courseCards = List <PublicationCard> ();

    publicationsListSnapshot.forEach(
            (p) {

              Publication publication = buildPublication(p);

              PublicationCard courseCard = PublicationCard(
                publication: publication,
                user: user
              );

          courseCards.add(courseCard);
        }
    );

    if (courseCards.isEmpty){

      //List <String> noPublicationMessages = ["¡Bienvenido!", "Añade tu primera publicación.", "empty"];

      PublicationCard courseCard = PublicationCard(
        //noCourseMessages: noCourseMessages,
        user: user,
      );

      courseCards.add(courseCard);

    }

    return courseCards;
  }

}