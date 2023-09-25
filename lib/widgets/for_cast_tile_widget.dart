import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ForCastTileWidget extends StatelessWidget {
  String? temp;
  String? imageUrl;
  String? time;
  ForCastTileWidget({
    Key? key,
    this.temp,
    this.time,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            time!,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Image.asset(
            imageUrl ?? "", // 'assets/icons/Weather_big-icon.png',
            height: 50,
            width: 50,
          ),
          Text(
            temp!,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
