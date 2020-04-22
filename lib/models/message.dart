import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swchat/models/user.dart';

class Message{

  final String sender;
  final List<String> membres;
  final Timestamp time;
  final String text;
  final bool isLiked;
  final bool read;

  Message({
    this.sender,
    this.membres,
    this.time,
    this.text,
    this.isLiked,
    this.read
  });

}

class ContactMessage{

  UserData contact;
  Message lastMessage;

  ContactMessage({this.contact, this.lastMessage});

}