// String buildIcon(String icon, {bool isBigSize = true}) {
//   if (isBigSize) {
//     final weatherConditionIcons = {
//       '01d': 'assets/icons/sun.png',
//       // '02d': 'assets/icons/partly_cloudy.png', // Few clouds (day)
//       // '02n': 'assets/icons/partly_cloudy.png', // Few clouds (night)
//       // '03d': 'assets/icons/cloudy.png', // Scattered clouds (day)
//       // '03n': 'assets/icons/cloudy.png', // Scattered clouds (night)
//       '04d': 'assets/icons/CloudSun.png', // Broken clouds (day)
//       '10d': 'assets/icons/rain.png', // Rain (day)
//       // '10n': 'assets/icons/rain.png', // Rain (night)
//       // '11d': 'assets/icons/thunderstorm.png', // Thunderstorm (day)
//       // '11n': 'assets/icons/thunderstorm.png', // Thunderstorm (night)
//       '13d': 'assets/icons/snow.png', // Snow (day)
//     };

//     return weatherConditionIconsBig;
//   } else {
//     final weatherConditionIconsSmall = {
//       '01d': 'assets/icons/sun-s.png',
//       '04d': 'assets/icons/CloudSun.png', // Broken clouds (day)
//     };
//     return weatherConditionIconsSmall;
//   }
// }
String buildIcon(String icon, {bool isBigSize = true}) {
  final weatherConditionIcons = {
    '01d': isBigSize ? 'assets/icons/CloudSun.png' : 'assets/icons/sun-s.png',
    '01n': isBigSize
        ? 'assets/icons/sun.png'
        : 'assets/icons/CloudMoon.png', // Clear sky (night)
    '04d': 'assets/icons/CloudSun.png', // Broken clouds (day)
    '10d': 'assets/icons/rain.png', // Rain (day)
    '13d': 'assets/icons/snow.png', // Snow (day)
    '02d': 'assets/icons/CloudSun.png', // Few clouds (day)
    '02n': 'assets/icons/snow.png', // Few clouds (night)
    '03d': 'assets/icons/snow.png', // Scattered clouds (day)
    '03n': 'assets/icons/snow.png', // Scattered clouds (night)
    '04n': 'assets/icons/snow.png', // Broken clouds (night)
    '09d': 'assets/icons/rain.png', // Shower rain (day)
    '09n': 'assets/icons/rain.png', // Shower rain (night)
    '10n': 'assets/icons/snow.png', // Rain (night)
    '11d': 'assets/icons/snow.png', // Thunderstorm (day)
    '11n': 'assets/icons/snow.png', // Thunderstorm (night)
    '13n': 'assets/icons/snow.png', // Snow (night)
    '50d': 'assets/icons/snow.png', // Mist (day)
    '50n': 'assets/icons/snow.png', // Mist (night)
    // *note all icons need to modify
  };

  return weatherConditionIcons[icon] ??
      'assets/icons/sun.png'; // Default to 'sun' icon
}

String getWindDirectionText(int? degree) {
  if (degree == null) {
    return 'Unknown';
  }

  if (degree >= 337.5 || degree < 22.5) {
    return ''; //North wind
  } else if (degree >= 22.5 && degree < 67.5) {
    return ''; //Northeast wind
  } else if (degree >= 67.5 && degree < 112.5) {
    return ''; //East wind
  } else if (degree >= 112.5 && degree < 157.5) {
    return ''; //Southeast wind
  } else if (degree >= 157.5 && degree < 202.5) {
    return ''; //South wind
  } else if (degree >= 202.5 && degree < 247.5) {
    return ''; //Southwest wind
  } else if (degree >= 247.5 && degree < 292.5) {
    return ''; //West wind
  } else if (degree >= 292.5 && degree < 337.5) {
    return '';
  } else {
    return 'Unknown';
  }
}
