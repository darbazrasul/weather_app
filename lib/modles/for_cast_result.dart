import 'package:weather_app/modles/weather_result.dart';

class ForCastResult {
  List<ListResult>? list;

  ForCastResult({this.list});

  ForCastResult.fromJson(Map<String, dynamic> json) {
    print('Parsing ForCastResult: $json');
    if (json['list'] != null) {
      list = <ListResult>[];
      json['list'].forEach((v) {
        list!.add(ListResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListResult {
  int? dt;
  Main? main;
  List<Weather>? weather;

  ListResult({
    this.dt,
    this.main,
    this.weather,
  });

  ListResult.fromJson(Map<String, dynamic> json) {
    print('Parsing ListResult: $json');
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
