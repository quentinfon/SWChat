import 'package:swchat/models/message.dart';
import 'package:swchat/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String uid;
  final List<Map<String, dynamic>> listeDeContact;
  final List<String> listeDeContactFav;
  final List<String> membreDiscussion;
  final List<UserData> contacts;

  DatabaseService({this.uid, this.listeDeContact, this.membreDiscussion, this.contacts, this.listeDeContactFav});

  // collection reference
  final CollectionReference profilCollection = Firestore.instance.collection('profil');
  final CollectionReference messageCollection = Firestore.instance.collection('messages');

  Future updateUserData(String nom, String bio, String urlImage, List<Map<String, dynamic>> contact, List<String> favoirteContact) async {
    return await profilCollection.document(uid).setData({
      'uid': uid,
      'nom': nom,
      'bio': bio,
      'urlImage': urlImage,
      'contact': contact,
      'favoirteContact': favoirteContact
    });
  }

  Future setTimeLastMsg(UserData contact1, UserData contact2) async {

    List<Map<String, dynamic>> listC1 = contact1.getContactList();
    for(Map<String, dynamic> contact in listC1){
      if(contact['uid'] == contact2.uid){
        contact['lastContact'] = Timestamp.now();
      }
    }

    List<Map<String, dynamic>> listC2 = contact2.getContactList();
    for(Map<String, dynamic> contact in listC2){
      if(contact['uid'] == contact1.uid){
        contact['lastContact'] = Timestamp.now();
      }
    }

    try{

      await profilCollection.document(contact1.uid).setData({
        'uid': contact1.uid,
        'nom': contact1.nom,
        'bio': contact1.bio,
        'urlImage': contact1.imageUrl,
        'favoirteContact': contact1.favoirteContact,
        'contact': listC1,
      });

      await profilCollection.document(contact2.uid).setData({
        'uid': contact2.uid,
        'nom': contact2.nom,
        'bio': contact2.bio,
        'urlImage': contact2.imageUrl,
        'favoirteContact': contact2.favoirteContact,
        'contact': listC2,
      });

      return true;
    }catch(e){
      return false;
    }
  }




  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){

    return UserData(
      uid: snapshot.data['uid'],
      nom: snapshot.data['nom'],
      bio: snapshot.data['bio'],
      imageUrl: snapshot.data['urlImage'],
      contact: UserData.contactListFromMListap(List<Map<String, dynamic>>.from(snapshot.data['contact'])),
      favoirteContact: List<String>.from(snapshot.data['favoirteContact'])
    );
  }

  List<UserData> _userDataListFromSnapshot(QuerySnapshot docs){

    List<UserData> fav = [];

    for (int i = 0; i < docs.documents.length; i++) {
      fav.add(_userDataFromSnapshot(docs.documents[i]));
    }

    return fav;

  }

  // get user doc stream
  Stream<UserData> get userData {

    return profilCollection.document(uid).snapshots().map(_userDataFromSnapshot);

  }

  // get user doc
  Future<UserData> getUserData() async{

    return _userDataFromSnapshot(await profilCollection.document(uid).get());

  }

  Stream<List<UserData>> get getListContact {

    List<String> liste = [];

    for(Map m in listeDeContact){
      liste.add('${m['uid']}');
    }

    if(liste.isEmpty){
      liste.add('null');
    }

    return profilCollection.where('uid', whereIn: liste).snapshots().map((_userDataListFromSnapshot));

  }
  Stream<List<UserData>> get getListContactFav {

    List<String> liste = listeDeContactFav.isEmpty ? [ 'null' ] : listeDeContactFav;

    return profilCollection.where('uid', whereIn: liste).snapshots().map((_userDataListFromSnapshot));

  }


  Message _lastMessageFromSnapshot(QuerySnapshot docs){

    if(docs.documents.isNotEmpty){
      DocumentSnapshot snapshot = docs.documents[0];

      return Message(
        isLiked: snapshot.data['isLiked'],
        membres:  List<String>.from(snapshot.data['membres']),
        read: snapshot.data['read'],
        sender: snapshot.data['sender'],
        text: snapshot.data['text'],
        time: snapshot.data['time'],
      );

      // Si ils sont en contact mais pas envoye de messages
    }else{

      return null;

    }

  }


  Message _messageFromSnapshot(DocumentSnapshot snapshot){

      return Message(
        isLiked: snapshot.data['isLiked'],
        membres:  List<String>.from(snapshot.data['membres']),
        read: snapshot.data['read'],
        sender: snapshot.data['sender'],
        text: snapshot.data['text'],
        time: snapshot.data['time'],
      );

  }

  List<Message> _listMessagesFromSnapshot(QuerySnapshot docs){

    List<Message> msg = [];

    for (int i = 0; i < docs.documents.length; i++) {
      msg.add(_messageFromSnapshot(docs.documents[i]));
    }

    return msg;

  }

  //Dernier message recu
  Stream<Message> get lastMessage{

    List<String> search = membreDiscussion..sort();

    return messageCollection.where('membres', isEqualTo: search).orderBy('time', descending: true).limit(1).snapshots().map(_lastMessageFromSnapshot);
  }


  //Messages d'un contact
  Stream<List<Message>> get allMessages{

    List<String> search = membreDiscussion..sort();

    return messageCollection.where('membres', isEqualTo: search).orderBy('time', descending: true).snapshots().map(_listMessagesFromSnapshot);
  }


  List<ContactMessage> convertContactMessage(QuerySnapshot docs){

    List<ContactMessage> listContactMessage = [];

    for (int i = 0; i < docs.documents.length; i++) {

      ContactMessage contact = ContactMessage(lastMessage: _messageFromSnapshot(docs.documents[i]));

      for(UserData user in this.contacts){
        if(contact.lastMessage.membres.contains(user.uid)){
          contact.contact = user;
        }
      }

      listContactMessage.add(contact);
    }

    return listContactMessage;


  }

  //Edit du profil
  Future profilUpdate(String nom, String bio, String urlImage) async {
    return await profilCollection.document(uid).updateData({
      'uid': uid,
      'nom': nom,
      'bio': bio,
      'urlImage': urlImage,
    });
  }

  // get all users
  Stream<List<UserData>> get allUsersData {

    return profilCollection.snapshots().map((_userDataListFromSnapshot));

  }


}