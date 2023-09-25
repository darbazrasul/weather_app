import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/src/helper/assets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();
  int cSelect = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyLayout,
    );
  }

  get _bodyLayout => Stack(
        children: [
          _background,
          _body,
        ],
      );

  get _body => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              locationWidget(),
              weatherIcon(),
              temperature(),
              detailsWidget(),
              hourlyCastWidget(),
              windHumidityWidget(2, 100),
            ],
          ),
        ),
      );

  Center temperature() {
    return Center(
      child: Text(
        "28º",
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w700,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
          color: Colors.white,
          height: 1.25,
        ),
      ),
    );
  }

  static Color? lerp(Color? a, Color? b, double tt) {
    var t = tt;
    if (t > 0.5) {
      t = 1.0 - t;
    }
    t *= 2.0;
    if (b == null) {
      if (a == null) {
        return null;
      } else {
        return _scaleAlpha(a, 1.0 - t);
      }
    } else {
      if (a == null) {
        return _scaleAlpha(b, t);
      } else {
        return Color.fromARGB(
          _clampInt(_lerpInt(a.alpha, b.alpha, t).toInt(), 0, 255),
          _clampInt(_lerpInt(a.red, b.red, t).toInt(), 0, 255),
          _clampInt(_lerpInt(a.green, b.green, t).toInt(), 0, 255),
          _clampInt(_lerpInt(a.blue, b.blue, t).toInt(), 0, 255),
        );
      }
    }
  }

  static int _clampInt(int value, int min, int max) {
    assert(min <= max);
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  static double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  static int _lerpInt(int a, int b, double t) {
    return a + ((b - a) * t).round();
  }

  static Color _scaleAlpha(Color color, double factor) {
    return Color.fromARGB(
      _clampInt((color.alpha * factor).round(), 0, 255),
      color.red,
      color.green,
      color.blue,
    );
  }

  Center weatherIcon() {
    return Center(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _BackgroundPainter(
                  lerp(Color(0xffBD87FF), Color.fromARGB(255, 255, 255, 255),
                          _controller.value) ??
                      Colors.green,
                  lerp(
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 238, 103, 226),
                          _controller.value) ??
                      Colors.green,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(
                    Assets.assetsIconsW1,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding locationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        children: [
          Image.asset(
            Assets.assetsIconsLocation,
            width: 24,
            height: 24,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "Архангельск, Россия",
            style: TextStyle(
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 17,
                color: Colors.white),
          )
        ],
      ),
    );
  }

  get _background => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0700FF),
              Color(0xff000000),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );

  detailsWidget() {
    return Column(
      children: [
        Center(
          child: Text(
            "Гроза",
            style: TextStyle(
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontSize: 17,
              color: Colors.white,
              height: 1.411,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Макс.: 31º Мин: 25º",
            style: TextStyle(
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontSize: 17,
              color: Colors.white,
              height: 1.411,
            ),
          ),
        ),
      ],
    );
  }

  hourlyCastWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text("Сегодня",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17)),
                Spacer(),
                Text("20 марта",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weatherDetails(
                "14:00",
                Assets.assetsIconsSun,
                "25º",
                0,
              ),
              weatherDetails(
                "14:00",
                Assets.assetsIconsCloudRain,
                "25º",
                1,
              ),
              weatherDetails(
                "16:00",
                Assets.assetsIconsCloudLightning,
                "17º",
                2,
              ),
              weatherDetails(
                "17:00",
                Assets.assetsIconsW1,
                "17º",
                3,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget weatherDetails(String time, String img, String temp, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          cSelect = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: index == cSelect
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(1),
                ),
              )
            : null,
        child: Column(children: [
          Text(
            time,
            style: TextStyle(
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Image.asset(
            img,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            temp,
            style: TextStyle(
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      ),
    );
  }

  windHumidityWidget(int wind, int humidity) {
    return Padding(
      padding: const EdgeInsets.only(bottom:15),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        
        width: double.infinity,
        decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(children: [
            Row(
              children: [
                Image.asset(
                  Assets.assetsIconsSun,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Text(
                    "$wind м/с",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.2),
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  flex: 5,
                  child: Text(
                    "Ветер северо-восточный",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  Assets.assetsIconsCloudSnow,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Text(
                    "$humidity%",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.2),
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
               const Expanded(
                  flex: 5,
                  child: Text(
                    "Высокая влажность",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter(this.color1, this.color2);

  Color color1;
  Color color2;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color1,
          color2,
          // Color.fromARGB(255, 255, 0, 204),
          // Color.fromARGB(255, 178, 186, 14),
        ],
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,
      ).createShader(rect);

    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawCircle(rect.center, rect.center.dx + 15, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
