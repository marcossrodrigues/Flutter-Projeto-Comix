import 'package:comixapp/telas/homeAdm.dart';
import 'package:comixapp/telas/login_usuario.dart';
import 'package:comixapp/telas/registration_usuario.dart';
import 'package:flutter/material.dart';

class HomeComix extends StatefulWidget {
  const HomeComix({Key? key}) : super(key: key);

  @override
  State<HomeComix> createState() => _HomeComixState();
}

class _HomeComixState extends State<HomeComix> {


  @override
  Widget build(BuildContext context) {

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF9a0a0a),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 400,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUsuario()));
        },
        child: Text("Login", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF9a0a0a),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 400,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationUsuario()));
        },
        child: Text("Cadastre-se", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.book,
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdm()));
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
                      registerButton,
                      SizedBox(height: 15),
                      loginButton,
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
}

