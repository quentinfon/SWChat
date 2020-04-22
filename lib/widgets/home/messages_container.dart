import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/message.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/shared/loading.dart';

class MessagesContainer extends StatefulWidget {

  final String uidContact;

  MessagesContainer({this.uidContact});

  @override
  _MessagesContainerState createState() => _MessagesContainerState();
}

class _MessagesContainerState extends State<MessagesContainer> {

  List<Message> messages = [];

  String getTime(Message msg){

    if(msg != null){
      var date = msg.time.toDate();

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

  Widget _buildMessage(Message msg,bool isMe){

    return Row(
      children: <Widget>[
        Container(
          margin: isMe ? EdgeInsets.only(top: 8, bottom: 8, left: 80) : EdgeInsets.only(top: 8, bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            borderRadius: isMe ? BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ) : BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getTime(msg),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize:  16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                msg.text,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize:  16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        !isMe ? IconButton(
          icon: Icon(msg.isLiked ? Icons.favorite : Icons.favorite_border),
          iconSize: 30,
          color: msg.isLiked ? Colors.red : Colors.blueGrey,
          onPressed: () {},
        ) : SizedBox.shrink(),

      ],
    );

  }

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    if(user == null){

      return Loading();

    }else {

      return StreamBuilder<List<Message>>(
            stream: DatabaseService(membreDiscussion: [widget.uidContact, user.uid]).allMessages,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                messages = snapshot.data;
              }
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(top: 15),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index){
                    final Message msg = messages[index];
                    final bool isMe = msg.sender == user.uid;
                    return _buildMessage(msg, isMe);
                  },
                ),
              );
            }
      );
    }
  }
}
