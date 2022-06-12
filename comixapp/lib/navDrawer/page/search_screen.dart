import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comixapp/navDrawer/page/details_screen.dart';
import 'package:flutter/material.dart';

class TelaBusca extends StatefulWidget {
  @override
  State<TelaBusca> createState() => _TelaBuscaState();
}

class _TelaBuscaState extends State<TelaBusca> {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  String collectionName = "comic";
  // FirebaseStorage storageRef = FirebaseStorage.instance;

  var inputText = "";

  @override

  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            runSpacing: 6,
            spacing: 2,
            children: [
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7, right: 7),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (val) {
                    setState(() {
                      inputText = val;
                      print(inputText);
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 7, right: 7),
                child: Expanded(
                    child: Container(
                  child: StreamBuilder(
                      stream:
                          firestoreRef.collection(collectionName).where("name",isGreaterThanOrEqualTo: inputText).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Algo deu errado"),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Text("Carregando"),
                          );
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>TelaDetalhe(data))),
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(data['name']),
                                  leading: Image.network(data['capa'], height: 100, width: 70,fit: BoxFit.fill),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

