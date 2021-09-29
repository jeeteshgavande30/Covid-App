import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DisplayCard extends StatelessWidget {
  final String text;
  final String header;
  Color color = Colors.white;

  DisplayCard(
      {required this.text, required this.header, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            header,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
