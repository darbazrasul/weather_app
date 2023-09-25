import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weather_app/modles/for_cast_result.dart';
import 'package:weather_app/modles/weather_result.dart';
import 'package:weather_app/network/open_weather_map_client.dart';
import 'package:weather_app/state/state.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/for_cast_tile_widget.dart';
import 'package:weather_app/widgets/info_widget.dart';
import 'package:weather_app/widgets/weather_tile_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = Get.put(MyStateController());
  var location = Location();
  late StreamSubscription<LocationData> listener;
  late PermissionStatus permissionStatus;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
      await enableLocationListener();
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final isSmallScreen = constraints.maxWidth <= 600;

        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
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
            child: Obx(() {
              if (controller.locationData.value.latitude != null) {
                //  controller.locationData.value.latitude != null
                return FutureBuilder(
                  future: OpenWeatherMapClient()
                      .getWeather(controller.locationData.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('No Data'));
                    } else {
                      var data = snapshot.data as WeatherResult;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 20),
                          WeatherTileWidget(
                            context: context,
                            title: data.name != null && data.name!.isNotEmpty
                                ? '${data.name}, ${data.countryName}' // Use countryName property here
                                : '${data.coord!.lat}/${data.coord!.lon}',
                            titleFontSize: isSmallScreen ? 12 : 16,
                            subTitle: DateFormat('dd-MMM-yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  (data.dt ?? 0) * 1000),
                            ),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                CustomPaint(
                                  painter: _BackgroundPainter(),
                                  child: Image.asset(
                                    buildIcon(
                                      data.weather![0].icon ?? '',
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height:
                                        MediaQuery.of(context).size.width * 0.5,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${data.main!.temp!.toStringAsFixed(0)}°',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 64,
                                  height: 1.25,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${data.weather![0].description}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  height: 1.411,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Макс.: ${data.main!.tempMax!.toStringAsFixed(0)}°C', // Max temperature
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      height: 1.411,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Мин: ${data.main!.tempMin!.toStringAsFixed(0)}°C', // Min temperature
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 15),
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Сегодня', // Today label
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())}', // Current date
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.white,
                                  thickness: 0.5,
                                ),
                                FutureBuilder(
                                  future: OpenWeatherMapClient().getForcast(
                                      controller.locationData.value),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text(snapshot.error.toString()));
                                    } else if (!snapshot.hasData) {
                                      return const Center(
                                          child: Text('No Data'));
                                    } else if (snapshot.data == null) {
                                      return const Center(
                                          child: Text('Data is Null'));
                                    } else {
                                      var data = snapshot.data as ForCastResult;
                                      return Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: data.list!.length,
                                          itemBuilder: (context, index) {
                                            var item = data.list![index];
                                            return ForCastTileWidget(
                                              imageUrl: buildIcon(
                                                  item.weather![0].icon ?? '',
                                                  isBigSize: false),
                                              temp:
                                                  '${item.main!.temp!.toStringAsFixed(0)}°',
                                              time: DateFormat('HH:mm').format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        (item.dt ?? 0) * 1000),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            height: 96,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: Column(
                              children: [
                                InfoWidget(
                                  text:
                                      '${getWindDirectionText(data.wind?.deg)} ${data.wind?.speed?.toStringAsFixed(0) ?? "0"} м/с',
                                  image: 'assets/icons/Wind.png',
                                  textTow: 'Ветер северо-восточный',
                                ),
                                InfoWidget(
                                  text: '${data.main!.humidity}%',
                                  image: 'assets/icons/Drop.png',
                                  textTow: 'Высокая влажность',
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'Waiting....',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
          ),
        );
      }),
    );
  }

  Future<void> enableLocationListener() async {
    controller.isEnableLocation.value = await location.serviceEnabled();
    if (!controller.isEnableLocation.value) {
      controller.isEnableLocation.value = await location.requestService();
      if (!controller.isEnableLocation.value) {
        return;
      }
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    } else if (permissionStatus == PermissionStatus.granted) {
      // You have permission, proceed with using location services
    }

    controller.locationData.value = await location.getLocation();
    listener = location.onLocationChanged.listen((event) {
      // Handle location updates here
    });
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..color = const Color(0xffBD87FF);

    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    canvas.drawCircle(rect.center, rect.center.dx, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
