import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoWidget extends StatelessWidget {
  String? image;
  String? text;
  String? textTow;
  InfoWidget({
    Key? key,
    this.image,
    this.text,
    this.textTow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image!,
            height: 24,
            width: 24,
          ),
          Expanded(
            child: Text(
              text!,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              textTow!,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    ));
  }
}
