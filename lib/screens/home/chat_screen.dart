import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/message.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/auth.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/home/message_composer.dart';
import 'package:swchat/widgets/home/messages_container.dart';
import 'package:swchat/widgets/user/apercu_contact.dart';


class ChatScreen extends StatefulWidget {

  //Contact actuel
  final String userUid;
  ChatScreen({this.userUid});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final AuthService _auth = AuthService();

  UserData contact;

  setContact () async{
    UserData c = await DatabaseService(uid: widget.userUid).getUserData();

    setState(() {
      contact = c;
    });
  }


  @override
  void initState(){
    super.initState();
    setContact();
  }


  @override
  Widget build(BuildContext context) {
    if(contact != null) {
      return StreamProvider<User>.value(
        value: AuthService().user,
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              title: Text(
                contact.nom,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                      builder: (_) => Scaffold(
                        appBar: AppBar(
                          title: Text(
                            'Infos contact',
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          ),
                          centerTitle: true,
                          elevation: 0,
                        ),
                        body: ApercuContact(contact: contact, userUid: Provider.of<User>(context).uid),
                      )
                    ));
                    },
                ),
              ],
              centerTitle: true,
              elevation: 0,
            ),

            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )
                      ),
                      child: MessagesContainer(uidContact: contact.uid),
                    ),
                  ),
                  MessageComposer(contact: contact),
                ],
              ),
            ),
        ),
      );
    }else{
      return  Loading();
    }
  }
}
