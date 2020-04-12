import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/Publication/ui/widgets/publication_card.dart';
import 'package:lineclass/User/model/user.dart';

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

  List <PublicationCard> buildPublications(List<DocumentSnapshot> coursesListSnapshot, User user) {

    List <PublicationCard> courseCards = List <PublicationCard> ();

    coursesListSnapshot.forEach(
            (c) {

          PublicationCard courseCard = PublicationCard(
          );

          courseCards.add(courseCard);
        }
    );

    if (courseCards.isEmpty){

      //List <String> noCourseMessages = ["¡Bienvenido!", "Añade tu primer curso con el botón verde :D", "empty"];

      PublicationCard courseCard = PublicationCard(
        //noCourseMessages: noCourseMessages,
      );

      courseCards.add(courseCard);

    }
    return courseCards;
  }

}