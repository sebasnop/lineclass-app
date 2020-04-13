import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/avatar_picture.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class PublicationCard extends StatelessWidget {

  final Publication publication;
  final User user;

  const PublicationCard({Key key, this.publication, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc bloc = BlocProvider.of<AppBloc>(context);

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double cardWidth = screenWidth * 0.88;
    double cardHeight = cardWidth * 0.3;

    if (publication != null) {

    DateTime currentDate = DateTime.now();
    DateTime publicationDate = publication.publicationDate.toDate();

    String dateText = "";

    Duration duration = currentDate.difference(publicationDate);

    print(duration.inHours);

    if (duration.inDays == 0){

      if (duration.inHours >= 4) {
        dateText = "Hoy";
      } else if (duration.inHours == 3) {
        dateText = "Hace tres horas";
      } else if (duration.inHours == 2) {
        dateText = "Hace dos horas";
      } else if (duration.inHours == 1) {
        dateText = "Hace una hora";
      } else if (duration.inHours == 0) {
        dateText = "Reciente";
      }

    } else if(duration.inDays == 1){
      dateText = "Ayer";
    } else if (duration.inDays >= 2 && duration.inDays <= 30){
      dateText = "Hace ${duration.inDays} días";
    } else if (duration.inDays >= 31 && duration.inDays < 365){
      double monthsDouble = duration.inDays/31;
      int months = monthsDouble.floor();
      dateText = "Hace $months meses";
    } else if (duration.inDays >= 365){
      double yearsDouble = duration.inDays/31;
      int years = yearsDouble.floor();
      dateText = "Hace $years años";
    }

    Container title = Container (
      height: cardHeight*0.5,
      width: cardWidth,
      padding: EdgeInsets.only(left:25, top: 20, right: 20),
      alignment: Alignment.bottomLeft,
      child: Text(
        publication.title,
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w300
        ),
      ),
    );

    Container publisherName (String name) {

      return Container(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Color(0xff979797),
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
            width: cardWidth * 0.7,
            height: cardHeight * 0.5,
            padding: EdgeInsets.only(left: 25, bottom: 4),
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                AvatarPicture(side: 20, user: publisher,),
                publisherName(name)
              ],
            )
        );

      } else {
        return Container(child: OwnCircularProgress(height: 10, width: 10,));
      }

    }

    Container date = Container(
      width: cardWidth * 0.3,
      height: cardHeight * 0.5,
      padding: EdgeInsets.only(right: 25, bottom: 4),
      alignment: Alignment.centerRight,
      child: Text(
        dateText,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xff979797),
            fontFamily: "Comfortaa",
            fontSize: 11,
        ),
      ),
    );

    Widget info (DocumentSnapshot getPublisher) {
      return Row(
        children: <Widget>[
          publisherInfo(getPublisher),
          date
        ],
      );
    }

      InkWell card (DocumentSnapshot getPublisher) {
        return InkWell(
            onTap: () {},
            child: Container(
              height: cardHeight,
              width: cardWidth,
              margin: EdgeInsets.only(bottom: 35),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(1, 2))
                  ]
              ),
              child: Column(
                children: <Widget>[
                  title,
                  info(getPublisher)
                ],
              ),
            )
        );
      }

      Stream <DocumentSnapshot> getPublisher = bloc.user.getUser(user.uid);

      return StreamBuilder(
        stream: getPublisher,
        builder: (context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return card(snapshot.data);
            case ConnectionState.done:
              return card(snapshot.data);
            case ConnectionState.active:
              return card(snapshot.data);
            case ConnectionState.none:
              return card(snapshot.data);
            default:
              return card(snapshot.data);
          }
        },
      );

    } else {

      Container title = Container (
        height: cardHeight*0.5,
        width: cardWidth,
        padding: EdgeInsets.only(left:25, top: 20, right: 20),
        alignment: Alignment.bottomLeft,
        child: Text(
          "¡Crea tu primera publicación!",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300
          ),
        ),
      );

      Container subtitle = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 25),
        height: cardHeight*0.5,
        child: Text(
          "Usa el botón azul : )",
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Color(0xff979797),
              fontFamily: "Comfortaa",
              fontSize: 11
          ),
        ),
      );

    return Container(
      height: cardHeight,
      width: cardWidth,
      margin: EdgeInsets.only(bottom: 35),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12,
                blurRadius: 8,
                offset: Offset(1, 2))
          ]
      ),
      child: Column(
        children: <Widget>[
          title,
          subtitle
        ],
      ),
    );

    }


    }

  }

