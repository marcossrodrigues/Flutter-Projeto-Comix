import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final String comicImg, comicTitle;

  const ComicCard({Key? key, required this.comicImg, required this.comicTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 130,
      child: Column(
        children: [
          Expanded(flex: 90,
          child: Container(
            child: Image.network(comicImg, fit: BoxFit.cover,),
          ),
          ),
          Expanded(flex: 30,
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
