import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comixapp/model/usuario_model.dart';
import 'package:comixapp/telas/home.dart';
import 'package:comixapp/telas/telaInicial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PassaTelaUser extends StatefulWidget {
  @override
  _PassaTelaUserState createState() => _PassaTelaUserState();
}

class _PassaTelaUserState extends State<PassaTelaUser> {
  _PassaTelaUserState();
  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();
  User? user = FirebaseAuth.instance.currentUser;
  UsuarioModel loggedInUser = UsuarioModel();
  var wrole;
  var emaill;
  var id;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("usuarios") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UsuarioModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        wrole = loggedInUser.role.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  routing() {
    if (wrole == 'com') {
      return TelaInicial();
    } else {
      return HomeComix();
    }
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    return routing();
  }
}