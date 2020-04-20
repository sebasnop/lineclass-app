import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/avatar_picture.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class PublicationScreen extends StatelessWidget {

  final Publication publication;
  final User user;

  const PublicationScreen({Key key, @required this.publication, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    DateTime publicationDate = publication.publicationDate.toDate();

    String dateText = "Publicado el ${publicationDate.day}/${publicationDate.month}/${publicationDate.year} - ${publicationDate.hour}:${publicationDate.minute}";

    Stream <DocumentSnapshot> getPublisher = bloc.user.getUser(publication.publisher.documentID);

    Widget title = Container (
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 5, left: 0),
      child: Text(
        publication.title,
        style: TextStyle(
          fontSize: 28,
          fontFamily: "Comfortaa",
        ),
      )
    );

    Widget description = Container (
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: 25, top: 15, left: 10, right: 5),
        child: Text(
          publication.description,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            fontWeight: FontWeight.w300
          ),
        )
    );

    Container publisherName (String name) {

      return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black26,
              fontFamily: "Comfortaa",
              fontSize: 11
          ),
        ),
      );

    }

    Container publisherInfo (DocumentSnapshot getPublisher) {

      String name;

      if (getPublisher != null) {

        User publisher = bloc.user.buildUser(getPublisher);
        name = "${publisher.firstName} ${publisher.firstLastName}";

        return Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                publisherName(name),
                AvatarPicture(side: 17, user: publisher,),
              ],
            )
        );

      } else {
        return Container(child: OwnCircularProgress(height: 10, width: 10,));
      }

    }

    Container publisher = Container (
      width: screenWidth-40,
      child: StreamBuilder(
      stream: getPublisher,
      builder: (context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Container(child: OwnCircularProgress(height: 10, width: 10,));
          case ConnectionState.done:
            return publisherInfo(snapshot.data);
          case ConnectionState.active:
            return publisherInfo(snapshot.data);
          case ConnectionState.none:
            return Container(child: OwnCircularProgress(height: 10, width: 10,));
          default:
            return Container(child: OwnCircularProgress(height: 10, width: 10,));
        }
      },
    )
    );


    Widget date = Container (
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(bottom: 5, left: 0, top: 5),
        child: Text(
          dateText,
          style: TextStyle(
              fontSize: 11,
              fontFamily: "Comfortaa",
              fontWeight: FontWeight.w200,
              color: Colors.black26
          ),
        )
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            title,
            Divider(),
            description,
            publisher,
            date,
          ],
        ),
      ),
    );
  }
}
