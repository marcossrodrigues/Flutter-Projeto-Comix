import 'package:carousel_slider/carousel_slider.dart';
import 'package:comixapp/components/comicCard.dart';
import 'package:comixapp/widgets/BotNavItem.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int selectedNavIndex = 0;
  bool mangaLoaded = false;
  late List<Map<String, dynamic>> mangaList;
  final urlImages = [
    'https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg',
    'https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg',
    'https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg',
    'https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg',
    'https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg',
    'https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg',
  ];

  void navBarTap(int index) {
    setState(() {
      selectedNavIndex = index;
    });
  }
  Widget buildImage(String urlImage, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 2),
    color: Colors.grey,
    width: double.infinity,
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );

  void fetchManga() async {
    // final webscraper = WebScraper(baseUrl);

    //if (await webscraper.loadWebPaga('/read')) {
    // mangaList = webscraper.getElement(address, attribs)
  //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comix"),
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
            runSpacing: 10,
            spacing: 5,
            children: [
              SizedBox(height: 4,),
              Container(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 260,
                   // viewportFraction: 1,
                    autoPlay: true,
                  ),
                  itemCount: urlImages.length,
                  itemBuilder: (context, index, realIndex){
                    final urlImage = urlImages[index];

                    return buildImage(urlImage, index);
                  },
                ),
              ),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
              ComicCard(comicImg: "https://pbs.twimg.com/media/EcbML9JWAAEsTcK.jpg", comicTitle: "Comic 01"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.white,
        onTap: navBarTap,
        currentIndex: selectedNavIndex,
        items: [
          botNavItem(Icons.explore_outlined, "Discover"),
          botNavItem(Icons.favorite, "Favorite"),
          botNavItem(Icons.watch_later, "Recent"),
          botNavItem(Icons.more_horiz, "More"),
        ],
      ),
    );
  }
}
