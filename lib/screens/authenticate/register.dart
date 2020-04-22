import 'package:swchat/services/auth.dart';
import 'package:swchat/shared/constants.dart';
import 'package:swchat/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password1 = '';
  String password2 = '';

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          'Inscription',
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Connexion',
              style: TextStyle(
                fontFamily: 'NunitoSans',
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Entrez un email' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val){
                  if(val.isEmpty){
                    return 'Entrez un mot de passe';
                  }else if(val != password2){
                    return 'Les mots de passes doivent etre identique';
                  }else if(val.length < 6){
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }else{
                    return null;
                  }
                },
                decoration: textInputDecoration.copyWith(hintText: 'Mot de passe'),
                onChanged: (val){
                  setState(() => password1 = val);
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val){
                  if(val.isEmpty){
                    return 'Entrez un mot de passe';
                  }else if(val != password1){
                    return 'Les mots de passes doivent etre identique';
                  }else if(val.length < 6){
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }else{
                    return null;
                  }
                },
                decoration: textInputDecoration.copyWith(hintText: 'Mot de passe'),
                onChanged: (val){
                  setState(() => password2 = val);
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.grey[800],
                child: Text(
                  'Inscription',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){

                    setState(() => loading = true);

                    dynamic result = await _auth.registerWithEmailAndPassword(email, password1);
                    if(result == null){
                      setState((){
                        error = 'Email invalide';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
