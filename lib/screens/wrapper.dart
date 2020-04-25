import 'package:swchat/models/user.dart';
import 'package:swchat/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:swchat/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Wrapper extends StatelessWidget {

  final MyAppSettings settings;
  Wrapper(this.settings);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either Home or Authenticate widget
    if(user == null){
      return Authenticate();
    }else{
      return Home(settings);
    }
  }

}
