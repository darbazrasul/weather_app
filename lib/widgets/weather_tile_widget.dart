import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WeatherTileWidget extends StatelessWidget {
  BuildContext? context;
  String? title;
  double? titleFontSize;
  String? subTitle;
  WeatherTileWidget({
    Key? key,
    this.context,
    this.title,
    this.titleFontSize,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
