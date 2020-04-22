import 'package:flutter/material.dart';
import 'package:swchat/models/message.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';


class ContactTile extends StatefulWidget {


  final UserData utilisateur;
  final UserData contact;

  ContactTile({this.contact, this.utilisateur});

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {

  Message msg;


  String getText(){
    if(msg != null){
      return msg.text;
    }else{
      return 'Envoyez un message';
    }
  }

  Color getColor(){
    if(msg != null && msg.read == false && msg.sender != widget.utilisateur.uid){
      return Color(0xFFFFEFEE);
    }
    return Colors.white;
  }

  String getTime(){

    if(msg != null){
      var date = DateTime.fromMillisecondsSinceEpoch(msg.time.millisecondsSinceEpoch);

      Duration d = DateTime.now().difference(date);

      if(d.inDays >= 2){
        return '${date.day}/${date.month}/${date.year}';
      }
      if(d.inDays >= 1){
        return 'Hier';
      }

      String heure = date.hour < 10 ? "0${date.hour}" : '${date.hour}';
      String minute = date.minute < 10 ? "0${date.minute}" : '${date.minute}';

      return ('$heure:$minute');
    }else{
      return "";
    }
  }

  bool messageVu(){
    if(msg != null && msg.read == false && msg.sender != widget.utilisateur.uid){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Message>(
      stream: DatabaseService(membreDiscussion: [widget.utilisateur.uid, widget.contact.uid]).lastMessage,
      builder:(context, snapshot){
        if(snapshot.hasData){
          msg = snapshot.data;
        }

        return Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, right: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: getColor(),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75.0),
                      child: ProfilImage(url: widget.contact.imageUrl),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.contact.nom,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          getText(),
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    getTime(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5),
                  !messageVu() ? Container(
                      width: 40,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'New',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      )
                  ) : Text('')
                ],
              ),
            ],
          ),
        );


      },

    );
  }
}
