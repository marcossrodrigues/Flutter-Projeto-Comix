import 'package:comixapp/telas/home.dart';
import 'package:comixapp/telas/login_Adm.dart';
import 'package:comixapp/telas/login_usuario.dart';
import 'package:comixapp/telas/registration_adm.dart';
import 'package:comixapp/telas/telaInicial.dart';
import 'package:comixapp/ui/home/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comix - Leitor de Quadrinhos',
      debugShowCheckedModeBanner: false,
      home: HomeComix(),
    );
  }
}
