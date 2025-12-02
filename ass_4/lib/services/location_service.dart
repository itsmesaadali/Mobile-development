import 'dart:html';

class LocationService {
  static Future<String> getLocationWeb() async {
    final pos = await window.navigator.geolocation.getCurrentPosition();
    return "${pos.coords!.latitude}, ${pos.coords!.longitude}";
  }
}
