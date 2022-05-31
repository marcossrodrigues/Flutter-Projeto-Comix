import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comixapp/telas/home.dart';
import 'package:comixapp/telas/menuAdm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/adm_model.dart';

class RegistrationAdm extends StatefulWidget {
  const RegistrationAdm({Key? key}) : super(key: key);

  @override
  State<RegistrationAdm> createState() => _RegistrationAdmState();
}

class _RegistrationAdmState extends State<RegistrationAdm> {
  final _auth = FirebaseAuth.instance;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  var options = [
    'adm',
  ];
  var _currentItemSelected = "adm";
  var rool = "adm";

  @override
  Widget build(BuildContext context) {

    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return ("Por favor digite seu Email");
        }
        // reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ("Por favor digite um Email Valido");
        }
        return null;
      },
      onSaved: (value){
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,

      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return ("Sua senha é necessaria para fazer Login");
        }
        if(!regex.hasMatch(value)){
          return("Por favor digite uma Senha Valida/Min. 6 Caracteres");
        }
      },
      onSaved: (value){
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Senha",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,

      validator: (value){
        if(confirmPasswordEditingController.text != passwordEditingController.text){
          return "As Senhas não Coincidem";
        }
        return null;
      },
      onSaved: (value){
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirme sua Senha",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // signup button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF9a0a0a),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 400,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text, rool);
        },
        child: Text("Cadastrar", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    // role
    final roleAdm = DropdownButton<String>(
      dropdownColor: Colors.blue[900],
      isDense: true,
      isExpanded: false,
      iconEnabledColor: Colors.white,
      focusColor: Colors.white,
      items: options.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(
            dropDownStringItem,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValueSelected) {
        setState(() {
          _currentItemSelected = newValueSelected!;
          rool = newValueSelected;
        });
      },
      value: _currentItemSelected,
    );


    return Scaffold(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: Image.asset("images/Logo.png", fit: BoxFit.contain,),
                      ),
                      SizedBox(height: 15),
                      emailField,
                      SizedBox(height: 15),
                      passwordField,
                      SizedBox(height: 15),
                      confirmPasswordField,
                      SizedBox(height: 15),
                      roleAdm,
                      SizedBox(height: 15),
                      signupButton,
                      SizedBox(height: 15),
                    ],
                  ),
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

  void signUp(String email, String password, String rool) async{
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        postDetailsToFirestore(email, rool),

      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
  postDetailsToFirestore(String email, String rool) async{

    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    AdmModel admModel = AdmModel();

    // writing all the values
    admModel.email = email;
    admModel.uid = user!.uid;
    admModel.role = rool;


    await firebaseFirestore
        .collection("adms")
        .doc(user.uid)
        .set(admModel.toMap());
    Fluttertoast.showToast(msg: "Conta Administradora Criada com Sucesso");
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MenuAdm()), (route) => false);


  }
}
