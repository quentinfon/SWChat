import 'package:flutter/material.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';


class ApercuContact extends StatefulWidget {

  final UserData contact;
  final String userUid;
  ApercuContact({this.contact, this.userUid});

  @override
  _ApercuContactState createState() => _ApercuContactState();
}

class _ApercuContactState extends State<ApercuContact> {


  UserData userData;

  bool peutEtreAjouter = false;
  UserData user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: widget.userUid).userData,
        builder: (context, snap) {
          if (snap.hasData) {
            userData = snap.data;
          }

          //Verification pour ajouter le contact
          if(userData != null && !userData.estEnContactAvec(widget.contact.uid) && userData.uid != widget.contact.uid){
            peutEtreAjouter = true;
          }


          return userData == null ? Loading() : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: ProfilImage(url: widget.contact.imageUrl),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.contact.nom,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NunitoSans'
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.contact.bio,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NunitoSans',
                          color: Colors.blueGrey
                      ),
                    ),
                    SizedBox(height: 10),
                    peutEtreAjouter ? FlatButton.icon(
                        onPressed: () async{

                          await DatabaseService().setTimeLastMsg(userData, widget.contact);
                          setState(() {
                            peutEtreAjouter = false;
                          });

                        },
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Ajouter au contacts',
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'NunitoSans'
                          ),
                        )
                    ) : SizedBox(),

                  ],
                ),
              ),
            ],
          );
        });
  }
}
