import 'package:comixapp/cadastrar/cad_Comic.dart';
import 'package:comixapp/telas/home.dart';
import 'package:comixapp/telas/registration_adm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuAdm extends StatefulWidget {
  const MenuAdm({Key? key}) : super(key: key);

  @override
  State<MenuAdm> createState() => _MenuAdmState();
}

class _MenuAdmState extends State<MenuAdm> {


  @override
  Widget build(BuildContext context) {

    final cadaAdmButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF9a0a0a),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 400,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationAdm()));
        },
        child: Text("Cadastrar Administrador", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final cadaQuadriButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF9a0a0a),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 400,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CadComic()));
        },
        child: Text("Quadrinhos", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9a0a0a),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: (){
              logout(context);
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: Image.asset("images/Logo.png", fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 15),
                    cadaAdmButton,
                    SizedBox(height: 15),
                    cadaQuadriButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("© 2022 Comix. All rights reserved.", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),)
        ],
      ),
    );
  }
  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeComix()));
  }
}

