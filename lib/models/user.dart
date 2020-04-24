import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String uid;

  User({this.uid});

}


class UserData {

  static UserData connectedUser;

  final String uid;
  final String nom;
  final String bio;
  final List<String> favoirteContact;
  final List<Contact> contact;
  final String imageUrl;

  UserData({this.uid, this.nom, this.bio, this.imageUrl, this.favoirteContact, this.contact});

  List<Map<String, dynamic>> getContactList(){
    List<Map<String, dynamic>> liste = [{}];

    for(Contact c in contact){
      liste.add({
        'uid': c.uid,
        'lastContact': c.lastMessage
      });
    }

    return liste;
  }


  static List<Contact> contactListFromMListap(List<Map<String, dynamic>> map){
    List<Contact> listeContact = [];
    for(Map<String, dynamic> c in map){

      listeContact.add(Contact(uid: c['uid'], lastMessage: c['lastContact']));

    }
    return listeContact;
  }


  static Contact getContact(String uid){
    if(connectedUser != null){
      for(Contact c in connectedUser.contact){
        if(c.uid == uid){
          return c;
        }
      }
    }
    return null;
  }

  static List<UserData> sortListContacts(List<UserData> listeContact){

    List<UserData> finalList = [];

    int nbContact = listeContact.length;

    for(int i = 0; i < nbContact; i++){
      //index du contact le plus recent
      int indexMax = 0;
      Timestamp lastMsgMax = Timestamp.fromMillisecondsSinceEpoch(0);

      for(int j = 0; j < listeContact.length; j++){

        if(getContact(listeContact[j].uid).lastMessage != null && getContact(listeContact[j].uid).lastMessage.millisecondsSinceEpoch > lastMsgMax.millisecondsSinceEpoch){
          indexMax = j;
          lastMsgMax = getContact(listeContact[j].uid).lastMessage;
        }

      }

      finalList.add(listeContact[indexMax]);
      listeContact.removeAt(indexMax);

    }

    return finalList;

  }

  bool estEnContactAvec(String uidContact){
    for(Contact c in contact){
      if(c.uid == uidContact){
        return true;
      }
    }
    return false;
  }

}



class Contact{

  final String uid;
  final Timestamp lastMessage;

  Contact({this.uid, this.lastMessage});


}
