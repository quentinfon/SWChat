import 'package:flutter/material.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';


class AjoutFavorisScreen extends StatefulWidget {

  final String userUid;
  AjoutFavorisScreen({this.userUid});

  @override
  _AjoutFavorisScreenState createState() => _AjoutFavorisScreenState();
}

class _AjoutFavorisScreenState extends State<AjoutFavorisScreen> {

  List<ContactFav> contacts = [];
  UserData user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des contacts',
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 25
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<UserData>(
        stream: DatabaseService(uid: widget.userUid).userData,
        builder:(context, snapshot) {

          if(snapshot.hasData){
            user = snapshot.data;
          }


          return user == null ? Loading() : StreamBuilder<List<UserData>>(
              stream: DatabaseService(
                  listeDeContact: user.getContactList()).getListContact,
              builder: (context, snapshot) {
                //Ajout des contacts (et de s'ils sont favoris)
                if (snapshot.hasData) {
                  contacts = [];
                  for (UserData c in snapshot.data) {
                    bool fav = false;
                    if (user.favoirteContact.contains(c.uid)) {
                      fav = true;
                    }
                    contacts.add(ContactFav(contact: c, estFav: fav));
                  }
                }

                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              ContactFav contactFav = contacts[index];

                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            75.0),
                                        child: ProfilImage(
                                            url: contactFav.contact.imageUrl),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                          contactFav.contact.nom,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'NunitoSans',
                                              letterSpacing: 1
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 40,
                                      icon: contacts[index].estFav
                                          ? Icon(
                                          Icons.star, color: Colors.yellow[700])
                                          : Icon(Icons.star_border,
                                          color: Colors.grey),
                                      onPressed: () async {
                                        List<String> listeFav = [];
                                        for (ContactFav c in contacts) {
                                          if (c.estFav) {
                                            listeFav.add(c.contact.uid);
                                          }
                                        }

                                        if (contactFav.estFav) {
                                          listeFav.remove(
                                              contactFav.contact.uid);
                                        } else {
                                          listeFav.add(contactFav.contact.uid);
                                        }
                                        DatabaseService(uid: widget.userUid).updateContactsFav(listeFav);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                );
              });
        })
    );
  }
}

class ContactFav{

  final UserData contact;
  bool estFav;

  ContactFav({this.contact, this.estFav});

}
