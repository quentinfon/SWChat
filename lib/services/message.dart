import 'package:cloud_firestore/cloud_firestore.dart';


class MessageService {


  // collection reference
  final CollectionReference messageCollection = Firestore.instance.collection('messages');


  Future sendMessage(List<String> listeMembres, String sender, String text) async{

    return await messageCollection.add({
      'isLiked': false,
      'read': false,
      'membres': listeMembres..sort(),
      'sender' : sender,
      'text' : text,
      'time' : Timestamp.fromMillisecondsSinceEpoch(Timestamp.now().millisecondsSinceEpoch+(3600*2*1000))
    });

  }

}