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
      'time' : FieldValue.serverTimestamp()
    });

  }
  
  Future updateReadMsg(List<String> membres, String uidSender){
    
    List<String> search = membres..sort();

    return messageCollection.where('membres', isEqualTo: search).where('sender', isEqualTo: uidSender).where('read', isEqualTo: false).getDocuments().then((reponse){
      reponse.documents.forEach( (doc){
        messageCollection.document(doc.documentID).updateData({
          'read': true
        });
      });
    });
    
  }

}