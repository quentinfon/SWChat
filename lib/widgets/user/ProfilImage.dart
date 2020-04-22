import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:swchat/services/dataHolder.dart';
import 'package:swchat/shared/loading.dart';


class ProfilImage extends StatefulWidget {

  final String url;
  ProfilImage({this.url});

  @override
  _ProfilImage createState() => _ProfilImage();
}

class _ProfilImage extends State<ProfilImage> {

  Uint8List imageFile;
  StorageReference photoReference = FirebaseStorage.instance.ref().child('users');

  getImage(String url){
    if(!requestedImages.contains(url)){
      int maxSize = 4*1024*1024;
      photoReference.child(url).getData(maxSize).then((data){
        this.setState((){
          imageFile = data;
        });
        imageData.putIfAbsent(url, (){
          return data;
        });
      }).catchError( (error){
        print(error);
      });
      requestedImages.add(url);
    }
  }

  Widget chargementOuPas(){
    if(imageFile == null){
      return Container(
        color: Colors.white,
        child: Center(
            child: Image.asset('assets/user-default.png')
        ),
      );
    }
    else{
      return Image.memory(
        imageFile,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void initState(){
    super.initState();

    String adresseImage = (widget.url == null || widget.url == '') ? "user-default.png" : widget.url;
    
    if(adresseImage != "user-default.png"){
      getImage(adresseImage);

      if(!imageData.containsKey(adresseImage)){
        getImage(adresseImage);
      }else{
        this.setState((){
          imageFile = imageData[adresseImage];
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return chargementOuPas();
  }
}
