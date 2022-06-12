import 'package:comixapp/components/passaTelaAdm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginAdm extends StatefulWidget {
  const LoginAdm({Key? key}) : super(key: key);

  @override
  State<LoginAdm> createState() => _LoginAdmState();
}

class _LoginAdmState extends State<LoginAdm> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
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
        emailController.text = value!;
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
      controller: passwordController,
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
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
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

    // login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF9a0a0a),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 400,
        onPressed: () {signIn(emailController.text, passwordController.text);

        },
        child: Text("Login", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                      loginButton,
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

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                PassaTelaAdm()), (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: "Usuario Não Encontrado para esse Email");
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: "Senha Incorreta para esse Usuario");
        }
      }
    }
  }
}