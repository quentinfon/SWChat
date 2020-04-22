import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/message.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/screens/home/chat_screen.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/widgets/user/contact_tile.dart';
import 'package:swchat/screens/home/chat_screen.dart';


class ChatList extends StatefulWidget {

  UserData data;
  ChatList({this.data});

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {


  List<UserData> contacts = [];


  @override
  Widget build(BuildContext context) {
    UserData data = Provider.of<UserData>(context);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: StreamBuilder<List<UserData>>(
          stream: DatabaseService(listeDeContact: widget.data.getContactList()).getListContact,
          builder: (context, snap){

            if(snap.hasData){
              contacts = snap.data;

              UserData.connectedUser = data;
              contacts = UserData.sortListContacts(contacts);

            }

            return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10),
                scrollDirection: Axis.vertical,
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index){

                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(
                      builder: (_) => ChatScreen(userUid: contacts[index].uid),
                    )
                    ),
                    child: ContactTile(
                      contact: contacts[index],
                      utilisateur: widget.data,
                    ),
                  );
                },
              ),
            );
          },
        )
      ),
    );
  }
}
