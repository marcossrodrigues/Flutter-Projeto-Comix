import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final String comicImg, comicTitle;

  const ComicCard({Key? key, required this.comicImg, required this.comicTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 0, left: 7),
      height: 220,
      width: 120,
      child: Column(
        children: [
          Expanded(flex: 70,
          child: Container(
            child: Image.network(comicImg, fit: BoxFit.cover,),
          ),
          ),
          Expanded(flex: 10,
            child: Container(
              alignment: Alignment.center,
              child: Text(comicTitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                )
              ),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
