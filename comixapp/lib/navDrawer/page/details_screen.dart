import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TelaDetalhe extends StatefulWidget {
  var _Comics;

  TelaDetalhe(this._Comics);

  @override
  State<TelaDetalhe> createState() => _TelaDetalheState();
}

class _TelaDetalheState extends State<TelaDetalhe> {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  String collectionName = "comic";
  // FirebaseStorage storageRef = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9a0a0a),
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            runSpacing: 6,
            spacing: 2,
            children: [
              SizedBox(
                height: 5,
              ),
              SafeArea(child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(widget._Comics["capa"],
                              height: 250, width: 110, fit: BoxFit.fill)),
                      Text(widget._Comics['name']),
                      Text(widget._Comics['genero']),
                      Text(widget._Comics['discription']),
                      SizedBox(height: 8,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>View(url: widget._Comics['pdf'])));

                      }, child: Text("Ler"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;
  View({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9a0a0a),
      ),
      body: SfPdfViewer.network(url,
          controller: _pdfViewerController,
          pageLayoutMode: PdfPageLayoutMode.single),
    );
  }
}
