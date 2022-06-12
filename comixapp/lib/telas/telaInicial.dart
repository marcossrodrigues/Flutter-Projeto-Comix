import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comixapp/navDrawer/navigation_drawer.dart';
import 'package:comixapp/navDrawer/page/details_screen.dart';
import 'package:comixapp/navDrawer/page/search_screen.dart';
import 'package:comixapp/telas/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  String collectionName = "comic";
  // FirebaseStorage storageRef = FirebaseStorage.instance;

  final urlImages = [
    'https://www.einerd.com.br/wp-content/uploads/2014/06/Marvel-Heroes.jpg.webp',
    'https://pop.proddigital.com.br/wp-content/uploads/sites/8/2021/07/os-eternos-hq-31873877.jpg',
    'https://kanto.legiaodosherois.com.br/w600-h600-k1/wp-content/uploads/2017/12/legiao_8YSA2JKwkGpctaRNnVzErxv1B96LXhiHQM5e34ZUbI.jpg.jpeg',
    'https://d5y9g7a5.rocketcdn.me/wp-content/uploads/2020/01/historias-em-quadrinhos-conheca-sua-historia-e-repercussao-pelo-mundo-12-1024x685.jpg',
  ];

  List _Comics = [];

  fetchComics() async {
    QuerySnapshot qn = await firestoreRef.collection(collectionName).get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _Comics.add({
          "capa": qn.docs[i]["capa"],
          "name": qn.docs[i]["name"],
          "discription": qn.docs[i]["discription"],
          "genero": qn.docs[i]["genero"],
          "pdf": qn.docs[i]["pdf"],
        });
      }
    });
    return qn.docs;
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        width: double.infinity,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  @override
  void initState() {
    fetchComics();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Comix"),
        backgroundColor: Color(0xFF9a0a0a),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            runSpacing: 6,
            spacing: 2,
            children: [
              SizedBox(
                height: 4,
              ),
              Container(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 260,
                    // viewportFraction: 1,
                    autoPlay: true,
                  ),
                  itemCount: urlImages.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = urlImages[index];

                    return buildImage(urlImage, index);
                  },
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 7, right: 7),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Busque Quadrinhos Aqui",
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => TelaBusca())),
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 330,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _Comics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.9),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>TelaDetalhe(_Comics[index]))),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                  aspectRatio: 0.99,
                                  child: Image.network(_Comics[index]["capa"],
                                      height: 250, width: 110, fit: BoxFit.fill)),
                              Text(
                                  "${_Comics[index]["name"].length > 15 ? _Comics[index]['name'].substring(0, 15) + '...' : _Comics[index]['name']}")
                            ],
                          ),
                        ),
                      );
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeComix()));
  }
}

