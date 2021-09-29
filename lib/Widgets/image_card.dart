import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imgsrc;
  final Color color;
  final String text;
  const ImageCard(
      {Key? key, required this.imgsrc, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7.5,
      color: color,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: <Widget>[
            Image.asset(
              imgsrc,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'MPLUSRounded',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
