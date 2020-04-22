import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/services/message.dart';
import 'package:swchat/shared/loading.dart';


class MessageComposer extends StatefulWidget {
  @override
  _MessageComposerState createState() => _MessageComposerState();

  final UserData contact;

  MessageComposer({this.contact});
}

class _MessageComposerState extends State<MessageComposer> {

  String currentMsg = '';
  var inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    UserData userData;

    if(user == null){

      return Loading();

    }else {
      return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snap) {

          if(snap.hasData){
            userData = snap.data;
          }

          return userData == null ? Loading() : Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 70,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: inputController,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (val) {
                      currentMsg = val;
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'Envoyez un message ...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 25,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {
                    //Si le msg ne contient pas que des espaces
                    if (currentMsg
                        .replaceAll(new RegExp('[ ]'), '')
                        .length > 0) {
                      //Suppression des espaces inutiles
                      currentMsg = currentMsg.replaceAll(new RegExp('^[ ]*'), '');
                      currentMsg =
                          currentMsg.replaceAll(new RegExp('[ ]{2,}'), ' ');

                      //Envoie du message
                      MessageService().sendMessage([userData.uid, widget.contact.uid], userData.uid, currentMsg);
                      DatabaseService().setTimeLastMsg(userData, widget.contact);

                      setState(() {
                        currentMsg = '';
                        inputController.text = '';
                      });
                    }
                  },
                )
              ],
            ),
          );
        }
      );
    }
  }
}
