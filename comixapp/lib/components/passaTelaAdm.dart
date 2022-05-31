import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comixapp/model/adm_model.dart';
import 'package:comixapp/telas/home.dart';
import 'package:comixapp/telas/menuAdm.dart';
import 'package:comixapp/telas/telaInicial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PassaTelaAdm extends StatefulWidget {
  @override
  _PassaTelaAdmState createState() => _PassaTelaAdmState();
}

class _PassaTelaAdmState extends State<PassaTelaAdm> {
  _PassaTelaAdmState();
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
  AdmModel loggedInAdm = AdmModel();
  var wrole;
  var emaill;
  var id;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("adms") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInAdm = AdmModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInAdm.email.toString();
        wrole = loggedInAdm.role.toString();
        id = loggedInAdm.uid.toString();
      });
    });
  }

  routing() {
    if (wrole == 'adm') {

        return MenuAdm();

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