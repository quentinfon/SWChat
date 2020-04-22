import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/screens/home/chat_screen.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/user/BulleContact.dart';

class FavoriteContacts extends StatefulWidget {

  UserData data;
  FavoriteContacts({this.data});

  @override
  _FavoriteContactsState createState() => _FavoriteContactsState();
}

class _FavoriteContactsState extends State<FavoriteContacts> {

  List<UserData> favoris = [ ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Contacts favoris',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.blueGrey,
                  ),
                  onPressed: (){

                  },
                )
              ],
            ),
        ),
          Container(
            height: 90,
            child: StreamBuilder<List<UserData>>(
              stream: DatabaseService(listeDeContactFav: widget.data.favoirteContact).getListContactFav,
              builder:(context, snapshot){

                if(snapshot.hasData){
                  favoris = snapshot.data;
                }

                return ListView.builder(
                  padding: EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: (favoris.length+1),
                  itemBuilder: (BuildContext context, int index){

                    if(index == favoris.length){

                      return IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Colors.grey,
                        ),
                        iconSize: 60,
                        onPressed: () {},
                      );
                    }

                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(
                        builder: (_) => ChatScreen(userUid: favoris[index].uid),
                      )
                      ),
                      child: BulleContact(
                          data: favoris[index]
                      ),
                    );
                  },
                );
              },

            ),
          )
      ],
      ),
    );
  }
}
