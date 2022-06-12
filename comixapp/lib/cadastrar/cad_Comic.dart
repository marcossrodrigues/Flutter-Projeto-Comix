import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadComic extends StatefulWidget {
  const CadComic({Key? key}) : super(key: key);

  @override
  State<CadComic> createState() => _CadComicState();
}

class _CadComicState extends State<CadComic> {

  PlatformFile? pickedFile;
  UploadTask? uploadTaskpdf;

  Future pdfPicker () async{
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
    if(result!=null){
      setState(() {
        pdfName = pickedFile!.name.toString();
      });
    }
  }

  String pdfName = "";
  String imageName = "";
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  var descriptionController = new TextEditingController();
  var nameController = new TextEditingController();
  var idController = new TextEditingController();
  var generoController = new TextEditingController();


  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionImg = "Capa";
  String collectionName = "comic";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
              children: [
                pdfName=="" ? Container() : Text("${pdfName}"),
                OutlinedButton(onPressed: (){
                  pdfPicker();
                }, child: Text("Selecione um PDF")),
                SizedBox(height: 8,),
                imageName=="" ? Container() : Text("${imageName}"),
                SizedBox(height: 7,),
                OutlinedButton(onPressed: (){
                  imagePicker();
                }, child: Text("Selecione uma Imagem")),
                SizedBox(height: 7,),
                TextFormField(
                  controller: idController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: "Id", border: OutlineInputBorder()),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: nameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: "Nome", border: OutlineInputBorder()),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: generoController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: "Genero", border: OutlineInputBorder()),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "Descrição", border: OutlineInputBorder()),
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: (){

                  // UPDLOAD FUNCTION HERE
                  _uploadQuad();

                }, child: Text("Cadastrar")),
                Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                      future: firestoreRef.collection(collectionName).get(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator(),);
                        }else if(snapshot.hasData && snapshot.data!.docs.length > 0){
                          // SHOW DATA HERE
                          List<DocumentSnapshot> arrData = snapshot.data!.docs;
                          print(arrData.length);
                          return ListView.builder(
                              itemCount: arrData.length,
                              itemBuilder: (context , index){
                                return Card(child: Row(children: [
                                  Image.network(arrData[index]['capa'], height: 100, width: 100,fit: BoxFit.fill,loadingBuilder: (context, child, loadingProgress){
                                    if(loadingProgress==null){
                                      return child;
                                    } else{
                                      return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes! : null),);
                                    }
                                  }),
                                  SizedBox(width: 15,),
                                  Text(arrData[index]['name'].length>28 ? arrData[index]['name'].substring(0,28)+'...' : arrData[index]['name']),
                                ],));
                              });

                        }else{
                          return Center(child: Text("Sem Data Encontrada."),);
                        }
                  }),
                )
              ],
            ),
          )),
    );
  }

  _uploadQuad() async {
    setState(() {
      _isLoading = true;
    });

    var uniqueKey = firestoreRef.collection(collectionName).doc();
    String uploadFileName = DateTime.now().millisecondsSinceEpoch.toString()+'.jpg';
    Reference reference = storageRef.ref().child(collectionImg).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));
    final path = 'Comics/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskpdf = ref.putFile(file);

    final snapshot = await uploadTaskpdf!.whenComplete((){});


    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() + "\t" + event.totalBytes.toString());
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      var pdfUpPath = await snapshot.ref.getDownloadURL();

      // NOW HERE WILL INSERT RECORD INSIDE DATABASE REGARDING URL
      if(uploadPath.isNotEmpty){
        firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
          "id":idController.text,
          "name":nameController.text,
          "genero":generoController.text,
          "discription":descriptionController.text,
          "capa":uploadPath,
          "pdf":pdfUpPath
        }).then((value) => _showMessage("Gravação Inserida."));
      }else{
        _showMessage("Algo deu Errado na Gravação do Quadrinho.");
      }
      setState(() {
        _isLoading = false;
        idController.text = "";
        nameController.text = "";
        generoController.text = "";
        descriptionController.text = "";
        imageName = "";
        pdfName = "";
      });

    });
  }

  _showMessage(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),duration: const Duration(seconds: 3),));
  }


  imagePicker () async{
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }
  }

}
